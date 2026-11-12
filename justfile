set default-list := true

[windows]
set shell := ["cmd.exe", "/c"]

# Fail early unless this shell is elevated (Windows).
[windows]
_require-admin target:
    @NET FILE >nul 2>&1 || (echo ERROR: elevation required. Run from an elevated prompt, e.g. gsudo just {{target}} 1>&2 & exit /b 1)

# Link config files and agent instructions.
[unix]
setup:
    bash setup.sh

# Link config files and agent instructions.
[windows]
setup: (_require-admin "setup")
    setup.bat

# Update installed packages and tools.
[unix]
update:
    bash update.sh

# Update installed packages and tools.
[windows]
update: (_require-admin "update")
    update.bat

# Preview package/tool changes using each platform's dry-run support.
[macos]
dry-run:
    brew bundle check --global --verbose || true
    brew upgrade --cask --dry-run
    brew cleanup --dry-run

# Preview package/tool changes using each platform's dry-run support.
[linux]
dry-run:
    mise bootstrap --upgrade --dry-run
    apt-get -s upgrade
    apt-get -s autoremove --purge

# Preview package/tool changes using each platform's dry-run support.
[windows]
dry-run:
    winget upgrade

# Run shellcheck against all shell scripts in the repository.
[unix]
check:
    shellcheck *.sh
