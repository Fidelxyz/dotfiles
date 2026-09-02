# Instructions

- NEVER install system packages on the host unless explicitly instructed. If you need to run a package that is not installed, use `nix run nixpkgs#<package>` instead.
- If you do not have the tools for your tasks, **PAUSE** and **ASK FOR INSTRUCTIONS**. Do NOT install new packages.
- The user may have modified files between conversations. Accept the user's changes as-is; do NOT revert them.

## Defensive coding
Don't add error handling, fallbacks, or validation **for scenarios that can't happen**. Trust internal code and framework guarantees. **Only validate at system boundaries** (user input, external APIs).

# Dev environment tips

- ALWAYS consider calling **tools** before `bash` command line for file operations.
  - To list files, use `list` instead of `ls` command.
  - To read files, use `read` instead of `cat`, `head`, `tail` or `sed` commands.
  - To search for files, use `grep` or `glob` instead of `find`, `grep`, `fd`, `grep` or `awk` commands.
- To remove files, ALWAYS use `trash`. NEVER use `rm`.

## NodeJS
- Use `pnpm` as the package manager.
- Do NOT install packages for temporary use. Use `pnpx` to run tools.

## Python
- Use `uv` as the package manager.
- Do NOT create new virtual environments or install packages for temporary use. Use `uvx` to run tools.
