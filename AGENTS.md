# AGENTS.md

See `README.md` for the core tools list and repo guidelines. In addition:

- Treat source control as read-only: do not commit.
- Do not install packages via Homebrew, WinGet, or mise; edit the manifests.
- In manifests sort packages / tools alphabetically and include a comment per line on their function
- Verify changes: `bash -n setup.sh update.sh`; preview Linux with
  `mise bootstrap --dry-run`.
- Use UK English; be concise; ask when unsure.
