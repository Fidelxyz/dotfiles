# Instructions

- NEVER install system packages on the host unless explicitly instructed. If you need to run a package that is not installed, use `nix run` or `nix-shell` instead.
- If you do not have the tools for your tasks, **PAUSE** and **ASK FOR INSTRUCTIONS**. Do NOT install new packages.
- The user may have modified files between conversations. Accept the user's changes as-is; do NOT revert them.

# Subagents

You are authorized to create explicit subagents when bounded, independent delegation materially improves progress or verification.
Review every result from subagents after they complete their work.

# Coding Principles

- Do not preserve backward compatibility. Remove obsolete paths instead of adding compatibility layers, fallbacks, or migrations.
- Choose the simplest implementation that fully meets the current requirements. Avoid speculative abstractions, configuration, and indirection.
- Grow the system in layers. Start from the smallest version that works end to end, and add each new capability on top of a product that already works. Never trade a working product for unfinished complexity.
- Keep components modular and concerns clearly separated.
- Prefer established, well-maintained libraries when they reduce overall complexity or improve reliability. Do not reimplement common functionality without a clear reason.
- Lean on the dependencies already in the project before writing your own implementation or adding packages. Do not assume a library lacks a capability without checking its documentation and types.
- Make architectural decisions for the long term. Do not accept a stopgap that only works for now and is meant to be replaced later.

## Defensive coding
Don't add error handling, fallbacks, or validation **for scenarios that can't happen**. Trust internal code and framework guarantees. **Only validate at system boundaries** (user input, external APIs).

# Code Style

For production code (excluding temporary scripts), prioritize readability:

- Use blank lines to separate logical groups of related statements and to separate definitions, such as functions and structs.
- Format code clearly and consistently. Prioritize readability over minimizing line or character counts.
- Choose names thoughtfully. Use clear, semantically precise names that avoid ambiguity or confusion.

# Documentation

- Documentation **should NOT restating the implementation**.
- Use positive descriptions: describe what something does rather than what it does not do.

For user-facing documentation (e.g. README):
- Include only what users need to know.

For developer-facing documentation (e.g. code comments):
- Include only information that is not already evident from the code.

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
