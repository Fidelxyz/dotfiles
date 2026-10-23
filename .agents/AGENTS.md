# Working Rules

- Preserve user changes, including edits made between conversations.
- Use subagents when bounded, independent delegation materially improves progress or verification. Review every returned result.

# Design Principles

## Code Design
- Choose the simplest implementation that fully meets current requirements. Add abstractions, configuration, and extension mechanisms ONLY for concrete requirements.
- Keep components modular and concerns clearly separated. Extract functions to express distinct responsibilities, remove duplication, or hide implementation details.
- Judge complexity across callers and the complete workflow, not by line count. Wrappers that only forward calls need a concrete benefit.
- Keep decisions and their required dependencies within the same responsibility boundary. Callers should supply only information relevant to the operation.
- Do not preserve backward compatibility. Remove obsolete paths instead of adding compatibility layers, fallbacks, or migrations.
- Check the standard library and existing dependencies before implementing common functionality. Prefer established, well-maintained libraries when they reduce overall complexity or improve reliability.
- Make architectural decisions for the long term. Do not accept a stopgap that only works for now and is meant to be replaced later.
- Enable only the dependency features the project uses. Add build steps only when they serve a current requirement.

### Validation and Error Handling
- Always **fail fast** rather than using fallbacks. Expose all errors.
- Do not add error handling, fallbacks, or validation **for scenarios that cannot happen**. Trust internal code and framework guarantees. Validate input only at system boundaries, such as user input and external APIs.
- Minimize validation. Let downstream operations report failures instead of duplicating checks.

### Code Style
For production code (excluding temporary scripts), prioritize readability:
- Separate logical groups and definitions with blank lines.
- Organize code blocks for coherent top-to-bottom reading. Group related definitions by role, and order functions to follow the main processing flow.
  - e.g. constructors - public interfaces - internal implementation; entry points - processing stages - supporting helpers.
- Format consistently. Favoring readability over minimizing line or character counts.
- Use names that reflect the main responsibilities, objects, and behaviors in context. Include the subject in names unless the enclosing context already makes it clear.
  - e.g. `DB_SCHEMA` rather than `SCHEMA`; `open_file` rather than `open`; `file.open()` needs no repeated subject.

## Testing
- Give each test one independent behavior. Share repeated setup.
- Use concise names describing the expected outcome.
- **Keep test cases minimal.**
- Remove tests that merely restate the implementation or duplicate coverage.
- Keep test-only helpers and setup in test code.
- Production abstractions need a design benefit beyond enabling tests. Prefer existing interfaces before adding generics, wrappers, or production hooks solely for test setup.

## Documentation
- Use **positive descriptions**: describe what something does rather than what it does not do.
- Make terms and references unambiguous. Connect mechanisms to the consequences that explain the design.
- Include comparisons and assurances ONLY when they resolve a relevant question.

### Scope
- Update relevant documentation ONLY when existing descriptions become inaccurate or incomplete.
- User-facing documentation (e.g. README) should include ONLY what users need to use the product **rather than implementation details**.
- Developer documentation (e.g. code comments) should explain ONLY non-obvious purpose or reasoning that is **hard to infer from the code**.
- **Match the document's scope and level of detail.**

## Reminder for Frequent Mistakes

### No preserving history.
- **Design the final implementation as if the current requirements had been known from the start.**
- Keep code, tests, and documentation for meaningful behavior of the final design. Remove anything that exists only because of superseded requirements or intermediate implementation steps.
- When removing a feature, remove its tests rather than replacing them with assertions that the feature is absent.

# Change Scope

- Keep changes focused on the requested task. Preserve existing behavior during refactoring unless a behavior change is requested.
- Follow the project's organization and conventions.
- When creating or reorganizing commits, group them by independent intent and keep unrelated changes separate. Keep each commit complete and working.
- Follow Conventional Commits and describe the actual change and its purpose accurately in commit messages.

# Environment and Tools

- Never install system packages on the host unless explicitly instructed. For missing tool or environment dependencies, use `nix run` or `nix-shell`; if the required dependencies remain unavailable, PAUSE and ASK FOR INSTRUCTIONS.
- Prefer available file-operation tools over shell commands. When no suitable tool is available, use the shell; prefer `fd` and `rg` for searches.
- **Remove files with `trash`. NEVER `rm`.**

## Node.js
- Use `pnpm` as the package manager.
- Run temporary tools with `pnpx` rather than installing them.

## Python
- Use `uv` as the package manager.
- To run a script with missing Python packages, use `uv run --with <package>`.
- Run temporary tools with `uvx` rather than installing packages or creating virtual environments.
