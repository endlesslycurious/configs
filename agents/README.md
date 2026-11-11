# Global agent instructions

- Be concise in your responses; don't over elaborate.
- Don't guess! When different readings could produce significantly different output, ask the user for clarification.
- In plan mode, explore and discuss the problem, then agree a direction with the user; don't rush to present a plan.
- Cite the source when attributing a claim to a white paper, specification or documentation; don't paraphrase one from memory.

## Language

- Use UK English spelling and grammar.
- Short sentences, one idea each; active voice; present tense for instructions.
- One term per concept — never vary wording for style.
- Define each acronym on first use.

## Programming

- Keep changes pragmatic; don't refactor unrelated code, create frameworks or add functionality that was not requested.
- Minimise the solution, never the completeness: update every affected caller, test, fixture, config and doc in the same change.
- Prefer code solutions in this order: the current repo, existing dependencies, the standard library, then new code or dependencies.
- Verify changes by formatting, linting, building and testing, when tools are configured.
- Make one change at a time and verify it before starting the next.

## Testing

- Write tests with real assertions, verify they fail, then implement the code and verify they pass.
- Test observable behaviour, not implementation detail; a passing test should survive a refactor.
- Tests cover the error paths, not just the happy path!
- Fuzz parsers, decoders and anything handling untrusted input.
- If a test breaks, fix the root cause; never skip or weaken a test to make it pass.

## User approval required

- Treat source control as read-only unless the user directs otherwise; do not run mutating commands, for example `git add`, `git commit`, `git merge`, `git rebase`, `git push`, `git pull`, `p4 edit`, `p4 submit`, `p4 revert` or `p4 sync`.
- Treat cloud and cluster state as read-only unless the user directs otherwise. Reads are fine (`aws describe-*`, `aws list-*`, `aws get-*`, `kubectl get`, `kubectl describe`, `kubectl logs`, `helm list`, `terraform plan`); anything that creates, changes or destroys needs approval first.
- Treat databases as read-only unless the instance is local development or the user directs otherwise; writes and schema changes (`INSERT`, `UPDATE`, `DELETE`, `DROP`, `ALTER`, `TRUNCATE`, `mongosh` write methods) and schema migrations need approval first.
- Do not install packages or software via Homebrew (macOS), mise (Linux), or WinGet (Windows). Instead edit the package manifests in `~/configs/`; the user applies them.
- Do not add external dependencies, for example `uv add` or `go get`, without user approval.

## Tooling

Tools an agent should prefer when running shell commands. The installed set is recorded in `~/configs/mise/config.toml`, `~/configs/brew/Brewfile.*` and `~/configs/winget/*.txt`.

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
