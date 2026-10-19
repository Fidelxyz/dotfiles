# Working Rules

- Preserve user changes, including edits made between conversations.
- Use subagents when bounded, independent delegation materially improves progress or verification. Review every completed result.
- Before designing, writing, modifying, or reviewing code, tests, or documentation, use [coding-standards](skills/coding-standards/SKILL.md).

# Change Scope

- Keep changes focused on the requested task. Preserve existing behavior during refactoring unless a behavior change is requested.
- Follow the project's organization and conventions.
- When creating or reorganizing commits, group them by independent intent and keep unrelated changes separate. Keep each commit complete and working.
- Follow Conventional Commits and describe the actual change and its purpose accurately in commit messages.

# Environment and Tools

- Never install system packages on the host unless explicitly instructed. For missing tool or environment dependencies, use `nix run` or `nix-shell`; if the required dependencies remain unavailable, PAUSE and ASK FOR INSTRUCTIONS.
- Prefer available file-operation tools such as `list`, `read`, `grep`, and `glob` over shell commands. When no suitable tool is available, use the shell; prefer `fd` and `rg` for searches.
- **Remove files with `trash`. NEVER `rm`.**

## Node.js
- Use `pnpm` as the package manager.
- Run temporary tools with `pnpx` rather than installing them.

## Python
- Use `uv` as the package manager.
- To run a script with missing Python packages, use `uv run --with <package>`.
- Run temporary tools with `uvx` rather than installing packages or creating virtual environments.
