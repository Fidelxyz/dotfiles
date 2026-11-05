# Design Principles

## Code Design

- Always make the best decisions to enhance: **user experience, developer experience, and agency experience**.
- Choose the simplest implementation that fully meets current requirements. Add abstractions, configuration, and extension mechanisms ONLY for concrete requirements.
- Keep components modular and concerns clearly separated. Extract functions to express distinct responsibilities, remove duplication, or hide implementation details.
- Judge complexity across callers and the complete workflow, not by line count. Wrappers that only forward calls need a concrete benefit.
- Keep decisions and their required dependencies within the same responsibility boundary. Callers should supply only information relevant to the operation.
- Do not preserve backward compatibility. Remove obsolete paths instead of adding compatibility layers, fallbacks, or migrations.
- **Design the final implementation as if the current requirements had been known from the start.** Make architectural decisions for the long term and proactively refactor existing code when doing so improves the design.
- Minimizing dependencies is not required. Check the standard library and existing libraries before implementing common functionality. Prefer established, well-maintained libraries when they reduce overall complexity or improve reliability.
- Enable only the dependency features the project uses. Add build steps only when they serve a current requirement.

### Validation and Error Handling
- Always **fail fast** and expose all errors.
- Add error handling, fallbacks, or validation ONLY for scenarios reachable through supported usage.
- Validate input only at system boundaries, such as user input and external APIs. Trust internal code and framework guarantees, and let downstream operations report failures without duplicating checks.

### HERO: Preventing Over-Defense

Add safeguards only for concrete requirements and reachable scenarios. Use hashes, checksums, or fingerprints only when they replace a substantially more expensive operation and the result affects the next step.

Do not get bogged down in trivial details: obscure coding patterns, symbolic link race conditions, RTL text, and millisecond-level race conditions are all excluded from the scope, unless the scenario is reachable through explicitly supported usage, such as documented examples, public interfaces, or real-world data. Confirming reachability does not require you to reproduce the scenario, but "theoretically constructible" scenarios do not count.

Here are some common examples of over-defending:
- **H** Hashing every row to compare differences between two tables—when comparing cells directly would suffice
- **H** Writing a bunch of checksum files that no code ever reads
- **E** Hardening account security for an application with no users and no deployment
- **R** Repeatedly auditing a patch without writing a single line of functional code
- **O** Justifying a security measure by citing a previous layer of defense, rather than actual requirements
These are merely examples. A genuine issue should not be dismissed simply because it "looks like" one of them.

Note that the following examples are similar to those listed above but do not constitute over-defense:
- Comparing digests to skip re-reading large files that have already been read
- "Seemingly rare" inputs that would naturally arise from the project's documentation

### Final Design
- Keep code, tests, and documentation for meaningful behavior of the final design. Remove content that exists **only because of superseded requirements or intermediate implementation steps**, including revision instructions and modification history.
- When excluding content from the final product, omit the content, statements, and assertions announcing its exclusion.

### Code Style

For production code (excluding temporary scripts), prioritize readability:

- Separate logical groups and definitions with blank lines.
- Organize code blocks for coherent top-to-bottom reading. Group related definitions by role, and order functions to follow the main processing flow.
  - e.g. constructors - public interfaces - internal implementation; entry points - processing stages - supporting helpers.
- Format consistently and favor readability over minimizing line or character counts.
- Use names that reflect the main responsibilities, objects, and behaviors in context. Include the subject in names unless the enclosing context already makes it clear.
  - e.g. `DB_SCHEMA` rather than `SCHEMA`; `open_file` rather than `open`; `file.open()` needs no repeated subject.

## Testing

- Give each test one independent behavior and a concise name describing the expected outcome.
- **Keep test cases minimal.** Remove tests that merely restate the implementation or duplicate coverage.
- Share repeated setup and keep test-only helpers and setup in test code.
- Production abstractions need a design benefit beyond enabling tests. Prefer existing interfaces before adding generics, wrappers, or production hooks solely for test setup.

## Documentation

- Use **positive descriptions**: describe what something does rather than what it does not do.
- Make terms and references unambiguous. Connect mechanisms to the consequences that explain the design.
- Include comparisons and assurances ONLY when they resolve a relevant question.
- Use English for comments and documentation unless otherwise specified.

### Scope
- Update relevant documentation ONLY when existing descriptions become inaccurate or incomplete.
- **Match the existing document's scope and level of detail**:
  - User-facing documentation (e.g. README) should include ONLY what users need to use the product **rather than implementation details**.
  - Developer documentation (e.g. code comments) should explain ONLY non-obvious purpose or reasoning that is **hard to infer from the code**.

### Document Only Reusable Rules

Do not add permanent rules or comments just to prevent a ridiculous mistake from happening again.

For example, if the code mistakenly performed X, do not add a comment like this when fixing it:

> Do not perform X.

This is not a real design rule. It is just a memorial to a ridiculous mistake.

# Change Scope

- Keep changes focused on the requested task. Preserve existing behavior during refactoring unless a behavior change is requested.
- Follow the project's organization and conventions.
- When creating or reorganizing commits, group them by independent intent and keep unrelated changes separate. Keep each commit complete and working.
- Follow Conventional Commits and describe the actual change and its purpose accurately in commit messages.

# Interaction

- Preserve user changes, including edits made between conversations.
- Use subagents when bounded, independent delegation materially improves progress or verification. Review every returned result.
- Do not use ASCII art to draw diagrams, tables, etc. If you need to draw something, use Mermaid.
- When a task is complete, clean up any temporary files and directories that are no longer needed.

# Language and Expression

- Respond to user conversations or draft documents temporarily displayed to users in Chinese.
- Before producing content involving verbal expression, organize the logical flow of the text to ensure the contextual coherence between sentences.
- Use simple and direct expressions, avoiding overly ornate language.
- Use long sentences with complete grammatical structures. Employ complete verb-object structures to describe actions and their objects.
- Use full words and avoid abbreviations.
- Do not use phrases such as "instead of" or "rather than" or include irrelevant negative statements.
- Do not append a disclaimer at the end of every paragraph.
- Do not make comparisons unless the user specifically requests them.

# Environment and Tools

- Never install system packages on the host unless explicitly instructed. For missing tool or environment dependencies, use `nix run` or `nix-shell`; if the required dependencies remain unavailable, PAUSE and ASK FOR INSTRUCTIONS.
- Prefer available file-operation tools over shell commands. When no suitable tool is available, use the shell; prefer `fd` and `rg` for searches.
- Prefer the `ast-grep` and `ast-grep-outline` skills for structural search and exploration.
- **Remove files with `trash`. NEVER `rm`.**

## Node.js
- Use `pnpm` as the package manager.
- Run temporary tools with `pnpx` rather than installing them.

## Python
- Use `uv` as the package manager.
- To run a script with missing Python packages, use `uv run --with <package>`.
- Run temporary tools with `uvx` rather than installing packages or creating virtual environments.
