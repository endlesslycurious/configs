# Agent Instructions

Repo-specific additions only. Global agent instructions live in `agents/README.md`,
which is linked into the global agent configuration and applies here too. Where
the rules below are more specific, they take precedence, but they cannot relax
the Read-only rules.

See `README.md` for repo layout, core tools and the full conventions in
[Guidelines](README.md#guidelines).

## Guidelines

- Do not add `npm` or `Node` based tools or dependencies.
- Installs require user approval and action: do not run `just update` or
  `just setup` unless the user asks; `just check` and `just dry-run` are
  read-only.
- The intended toolset lives in `mise/config.toml`, `brew/Brewfile.*` and
  `winget/*.txt`; edit these to change it.
- Sort packages and tools alphabetically in every manifest.
- Annotate each manifest entry with a trailing comment describing its purpose.
- Add tools to every applicable platform manifest for parity.
- Core tools must be cross-platform; language toolchains and OS-specific tools
  are extras only.
- Prefer the author or publisher as the source; avoid unverified or third-party
  package or tool sources.

## Verify changes

```sh
bash -n setup.sh update.sh     # shell syntax
just check                     # shellcheck all repo shell scripts
just dry-run                   # preview package/tool changes
```

On a fresh clone where `just` is not installed yet, use the underlying
commands instead:

```sh
shellcheck setup.sh update.sh
mise bootstrap --dry-run
```

`setup.bat` and `update.bat` are not covered by these checks; review Windows
changes manually. CI runs a Trivy filesystem scan on pushes and PRs to `master`.
