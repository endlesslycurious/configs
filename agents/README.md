# Global agent instructions

In general:

- Be concise in your responses.
- Supply references with links or file:line for local code in answers.
- Don't guess! When different readings could produce significantly different output, ask the user for clarification.
- Keep changes pragmatic; don't refactor unrelated code or add functionality that was not requested.
- Where configured, changes must be verified by linting, building and testing.

## Language

- Use UK English spelling and grammar.
- Short sentences, one idea each; active voice; present tense for instructions.
- One term per concept — never vary wording for style.
- Define each acronym on first use.

## Things to avoid

- Treat source control as read-only; do not commit, merge, rebase, push or pull changes with Git.
- Do not install packages via Homebrew (macOS), mise (Linux), or WinGet (Windows).
- Do not add Python or Go module dependencies without user approval.

## Tooling

Tools an agent should prefer when running shell commands. The installed set is recorded in `mise/config.toml`, `brew/Brewfile.*` and `winget/*.txt`.

- [ast-grep](https://github.com/ast-grep/ast-grep) (`ast-grep`) — AST-based code search and rewrite across languages; use for structural queries and safe refactors, and `ast-grep outline` to explore symbols/imports/exports.
- [difftastic](https://github.com/Wilfred/difftastic) (`difft`) — syntax-aware structural diff; use to review changes without formatting noise, and to distinguish refactors from behavioural changes.
- [dust](https://github.com/bootandy/dust) — visual `du`; use `dust -d 1` to summarise disk usage by directory.
- [eza](https://github.com/eza-community/eza) — modern `ls` replacement; use `eza -l` for listings and `eza --tree` for a directory tree.
- [fd](https://github.com/sharkdp/fd) — fast, user-friendly alternative to `find`; respects `.gitignore` by default.
- [just](https://github.com/casey/just) — project task runner; check `just --list` before assuming build/test/lint commands.
- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) — fast recursive code/text search; use `--json` for structured output.
- [tealdeer](https://github.com/dbrgn/tealdeer) (`tldr`) — concise, example-driven command help.
- [uv](https://github.com/astral-sh/uv) — Python package and project manager; use `uv run` to execute inside the project environment and `uv sync` to install from the lockfile.
- [yq](https://github.com/mikefarah/yq) — query and edit YAML/XML/JSON (and more), preserving formatting and comments; use `-i` for in-place edits.

Prefer `rg` over `grep`, `fd` over `find`, `ast-grep` for structural edits, `eza` over `ls`, and `difft` when verifying your own changes.
