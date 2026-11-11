#!/usr/bin/env python3
"""Apply Catppuccin Latte/Frappe colours to Windows Terminal settings.

Installs both the Latte and Frappe tab/window themes, pins the app theme,
default profile colour scheme and default font face, and backs up settings.json
before writing. Frappe remains installed so switching is a small edit to the
defaults below. Safe to run repeatedly: it skips files that are already
configured.
"""

from __future__ import annotations

import argparse
import copy
import json
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path

LIGHT = "Catppuccin Latte"
DARK = "Catppuccin Frappe"

DEFAULT_COLOUR_SCHEME = LIGHT
DEFAULT_THEME = LIGHT

# Nerd Font variant, so oh-my-posh glyphs render instead of a missing-glyph box.
# Installed by winget as NerdFonts.JetBrainsMono; matches ghostty/config.ghostty.
DEFAULT_FONT_FACE = "JetBrainsMono Nerd Font Mono"


def strip_jsonc(text: str) -> str:
    """Return text with comments and trailing commas removed."""
    without_comments = []
    in_string = False
    escaped = False
    index = 0

    while index < len(text):
        char = text[index]

        if in_string:
            without_comments.append(char)
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            index += 1
            continue

        if char == '"':
            in_string = True
            without_comments.append(char)
            index += 1
            continue

        if char == "/" and index + 1 < len(text):
            next_char = text[index + 1]
            if next_char == "/":
                index += 2
                while index < len(text) and text[index] not in "\r\n":
                    index += 1
                continue
            if next_char == "*":
                index += 2
                while index + 1 < len(text) and not (
                    text[index] == "*" and text[index + 1] == "/"
                ):
                    if text[index] in "\r\n":
                        without_comments.append(text[index])
                    index += 1
                index += 2
                continue

        without_comments.append(char)
        index += 1

    cleaned = "".join(without_comments)
    result = []
    in_string = False
    escaped = False
    index = 0

    while index < len(cleaned):
        char = cleaned[index]

        if in_string:
            result.append(char)
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            index += 1
            continue

        if char == '"':
            in_string = True
            result.append(char)
            index += 1
            continue

        if char == ",":
            lookahead = index + 1
            while lookahead < len(cleaned) and cleaned[lookahead].isspace():
                lookahead += 1
            if lookahead < len(cleaned) and cleaned[lookahead] in "}]":
                index += 1
                continue

        result.append(char)
        index += 1

    return "".join(result)


def load_jsonc(path: Path) -> dict:
    text = path.read_text(encoding="utf-8-sig")
    value = json.loads(strip_jsonc(text))
    if not isinstance(value, dict):
        raise ValueError("settings root is not a JSON object")
    return value


def settings_paths(explicit: list[Path] | None) -> list[Path]:
    if explicit:
        return [path for path in explicit if path.is_file()]

    local_app_data = os.environ.get("LOCALAPPDATA")
    if not local_app_data:
        return []

    local = Path(local_app_data)
    return [
        path
        for path in (
            local
            / "Packages"
            / "Microsoft.WindowsTerminal_8wekyb3d8bbwe"
            / "LocalState"
            / "settings.json",
            local
            / "Packages"
            / "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe"
            / "LocalState"
            / "settings.json",
            local / "Microsoft" / "Windows Terminal" / "settings.json",
        )
        if path.is_file()
    ]


def load_themes(app_dir: Path) -> list[dict]:
    themes = []
    for name in ("latte-theme.json", "frappe-theme.json"):
        theme = json.loads((app_dir / name).read_text(encoding="utf-8-sig"))
        if not isinstance(theme, dict) or not isinstance(theme.get("name"), str):
            raise ValueError(f"{name} is not a Windows Terminal theme object")
        themes.append(theme)
    return themes


def merge(settings: dict, themes: list[dict]) -> dict:
    theme_list = settings.get("themes")
    if theme_list is None:
        theme_list = []
        settings["themes"] = theme_list
    elif not isinstance(theme_list, list):
        raise ValueError("themes is not a JSON array")

    indexes = {
        item["name"]: index
        for index, item in enumerate(theme_list)
        if isinstance(item, dict) and isinstance(item.get("name"), str)
    }

    for theme in themes:
        name = theme["name"]
        if name in indexes:
            theme_list[indexes[name]] = theme
        else:
            indexes[name] = len(theme_list)
            theme_list.append(theme)

    settings["theme"] = DEFAULT_THEME

    profiles = settings.get("profiles")
    if profiles is None:
        profiles = {}
        settings["profiles"] = profiles
    elif not isinstance(profiles, dict):
        raise ValueError("profiles is not a JSON object")

    defaults = profiles.get("defaults")
    if defaults is None:
        defaults = {}
        profiles["defaults"] = defaults
    elif not isinstance(defaults, dict):
        raise ValueError("profiles.defaults is not a JSON object")

    defaults["colorScheme"] = DEFAULT_COLOUR_SCHEME

    font = defaults.get("font")
    if font is None:
        font = {}
        defaults["font"] = font
    elif not isinstance(font, dict):
        raise ValueError("profiles.defaults.font is not a JSON object")

    font["face"] = DEFAULT_FONT_FACE
    return settings


def profile_entries(settings: dict) -> list[dict]:
    """Return the profile objects in profiles.list, ignoring malformed entries."""
    profiles = settings.get("profiles")
    if not isinstance(profiles, dict):
        return []

    entries = profiles.get("list")
    if not isinstance(entries, list):
        return []

    return [entry for entry in entries if isinstance(entry, dict)]


def profile_name(entry: dict) -> str:
    return str(entry.get("name") or entry.get("guid") or "<unnamed>")


def explicit_overrides(settings: dict) -> list[str]:
    overrides = []
    for entry in profile_entries(settings):
        if "colorScheme" not in entry:
            continue
        if entry["colorScheme"] != DEFAULT_COLOUR_SCHEME:
            overrides.append(profile_name(entry))
    return overrides


def explicit_font_overrides(settings: dict) -> list[str]:
    overrides = []
    for entry in profile_entries(settings):
        font = entry.get("font")
        if not isinstance(font, dict) or "face" not in font:
            continue
        if font["face"] != DEFAULT_FONT_FACE:
            overrides.append(profile_name(entry))
    return overrides


def backup_and_write(path: Path, settings: dict) -> Path:
    stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    backup = path.with_name(f"{path.name}.bak.{stamp}")
    suffix = 1
    while backup.exists():
        backup = path.with_name(f"{path.name}.bak.{stamp}-{suffix}")
        suffix += 1

    shutil.copy2(path, backup)
    text = json.dumps(settings, indent=4, ensure_ascii=False) + "\n"

    try:
        path.write_text(text, encoding="utf-8")
        json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        shutil.copy2(backup, path)
        raise

    return backup


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dry-run", action="store_true", help="report changes without writing"
    )
    parser.add_argument(
        "--settings",
        type=Path,
        action="append",
        help="explicit settings.json path (repeatable)",
    )
    args = parser.parse_args(argv)

    app_dir = Path(__file__).resolve().parent / "windows-terminal"
    try:
        themes = load_themes(app_dir)
    except (OSError, ValueError) as error:
        print(f"Could not load bundled themes: {error}", file=sys.stderr)
        return 1

    paths = settings_paths(args.settings)
    if not paths:
        print(
            "No Windows Terminal settings.json found "
            "(portable installs are not detected automatically)",
            file=sys.stderr,
        )
        return 1

    failed = False
    for path in paths:
        try:
            original = load_jsonc(path)
        except (OSError, ValueError, json.JSONDecodeError) as error:
            print(f"{path}: could not parse settings: {error}", file=sys.stderr)
            failed = True
            continue

        overrides = explicit_overrides(original)
        font_overrides = explicit_font_overrides(original)
        try:
            merged = merge(copy.deepcopy(original), copy.deepcopy(themes))
        except ValueError as error:
            print(f"{path}: could not merge settings: {error}", file=sys.stderr)
            failed = True
            continue

        if merged == original:
            print(f"{path}: already configured")
        elif args.dry_run:
            print(f"{path}: would update")
        else:
            try:
                backup = backup_and_write(path, merged)
            except (OSError, ValueError, json.JSONDecodeError) as error:
                print(f"{path}: update failed: {error}", file=sys.stderr)
                failed = True
                continue
            print(f"{path}: updated (backup: {backup.name})")

        if overrides:
            print(
                f"{path}: profiles with an explicit colorScheme bypass the default: "
                + ", ".join(overrides)
            )

        if font_overrides:
            print(
                f"{path}: profiles with an explicit font face bypass the default: "
                + ", ".join(font_overrides)
            )

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
