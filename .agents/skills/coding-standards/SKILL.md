---
name: coding-standards
description: Apply coding, testing, and documentation standards when designing, writing, modifying, or reviewing code, tests, or developer and user documentation.
---

# Coding Standards

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
- Remove tests that merely restate the implementation or duplicate coverage.
- Keep test-only helpers and setup in test code.
- Production abstractions need a design benefit beyond enabling tests. Prefer existing interfaces before adding generics, wrappers, or production hooks solely for test setup.

## Documentation

- Use **positive descriptions**: describe what something does rather than what it does not do.
- Make terms and references unambiguous. Connect mechanisms to the consequences that explain the design.
- Include comparisons and assurances ONLY when they resolve a relevant question.

### Scope
- Update relevant documentation ONLY when existing descriptions become inaccurate or incomplete.
- User-facing documentation should include ONLY what users need to use the product.
- Developer documentation and code comments should explain ONLY non-obvious purpose or reasoning that is **hard to infer from the code**.
- **Match the document's scope and level of detail.**
