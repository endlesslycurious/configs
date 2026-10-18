# Global agent instructions

In general:

- Use UK English spelling and grammar.
- Be concise and supply references with answers.
- Don't guess, ask for clarification.
- Keep changes pragmatic, don't refactor unrelated code.
- Changes must be verified by linting and testing.

## Things to avoid

- Treat source control as read-only; do not commit changes to Git.
- Do not install packages via Homebrew (macOS), mise (Linux), or WinGet (Windows).
- Do not add Python or Go module dependencies without user approval.

## Tooling

These are installed on all my machines (Homebrew on macOS, mise on Linux, WinGet on Windows). Prefer them over default shell equivalents.

### Search & navigation

- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) — fast recursive code/text search; use `--json` for structured output.
- [fd](https://github.com/sharkdp/fd) — fast, user-friendly alternative to `find`; respects `.gitignore` by default.
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder; interactive by default, but use `--filter` for non-interactive matching.
- [ast-grep](https://github.com/ast-grep/ast-grep) (`ast-grep`) — AST-based code search and rewrite across languages; use for structural queries and safe refactors, and `ast-grep outline` to explore symbols/imports/exports.

### Viewing

- [bat](https://github.com/sharkdp/bat) — `cat` with syntax highlighting and Git markers; use `bat --plain --pager=never` for clean non-interactive reads.
- [tealdeer](https://github.com/dbrgn/tealdeer) (`tldr`) — concise, example-driven command help.
- [eza](https://github.com/eza-community/eza) — modern `ls` replacement; use `eza -l` for listings and `eza --tree` for a directory tree.
- [dust](https://github.com/bootandy/dust) — visual `du`; use `dust -d 1` to summarise disk usage by directory.

### Editing

- [neovim](https://github.com/neovim/neovim) — modal editor; drive it headlessly with `nvim --headless` for scripted edits.

### Version control

- [lazygit](https://github.com/jesseduffield/lazygit) — terminal Git UI for humans; agents should prefer the `git` CLI directly.

### Task running

- [just](https://github.com/casey/just) — project task runner; check `just --list` before assuming build/test/lint commands.

### Data & diff

- [yq](https://github.com/mikefarah/yq) — query and edit YAML/XML/JSON (and more), preserving formatting and comments; use `-i` for in-place edits.
- [difftastic](https://github.com/Wilfred/difftastic) (`difft`) — syntax-aware structural diff; use to review changes without formatting noise, and to distinguish refactors from behavioral changes.

Agents: prefer `rg` over `grep`, `fd` over `find`, `ast-grep` for structural edits, `eza` over `ls`, and `difft` when verifying your own changes.
