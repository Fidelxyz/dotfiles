---
name: design-and-implement
description: Complete coding and refactoring tasks through architecture design,
  implementation signature design, test signature design, and implementation,
  waiting for user direction between stages. Use when the user wants to review
  the design at each stage before implementation.
disable-model-invocation: true
metadata:
  opencode/autoinvoke: false
---

# Design and Implement

Complete the following four stages in order. Between stages, end the response and wait for explicit user direction before continuing.

## Stage 1: Design the Architecture

Design and explain the architecture for the task. Design the final architecture as if the current requirements had been known from the start. Proactively refactor existing code when doing so improves the design within the task scope.

## Stage 2: Design the Implementation Signatures

Use the confirmed architecture to design related declarations. Cover implementation code, including functions, methods, types, and structure fields. Keep decisions and their dependencies within the same responsibility boundary. Callers should provide only information relevant to the operation.

List all declarations to add, remove, or change, grouped by logical structure. Show declarations in code blocks. Identify the source filename in a comment inside each code block.

> Example:
>
> ```typescript
> // src/config.ts
> type Options = { strict: boolean };
> function readConfig(path: string, options: Options): Config;  // added
> function parseConfig(text: string, options: Options): Config;  // modified
> function loadConfig(config: Config): boolean;  // renamed from `load`
> // function unloadConfig(config: Config): boolean;  // removed
> ```

For each related file, organize the declaration order for coherent top-to-bottom reading. Group related definitions by role, and order functions to follow the main processing flow, e.g. constructors - public interfaces - internal implementation; entry points - processing stages - supporting helpers. Proactively improve the existing declaration order wherever a clearer organization is possible.

Show the complete declaration order, connecting declarations with →. Bold changed declarations and label additions, removals, modifications, or reorders. Group nested members under their enclosing type; uninvolved internal members may be omitted. Organize declarations into logical groups and collapse unchanged groups.

> Example:
>
> `src/config.ts`:
>
> `Config` → `Options` → **`readConfig` (added)** → **`parseConfig` (modified)** → **`loadConfig` (renamed)** → **~~`unloadConfig`~~ (removed)** → `saveConfig`

## Stage 3: Design the Test Signatures

Use the confirmed architecture and implementation signatures to design related tests. Give each test one independent behavior and keep test cases minimal.

List test declarations to add, remove, or change, grouped by logical structure. Include test helpers and fixtures whose declarations change. Follow the same rules and format as stage 2.

## Stage 4: Implement

Implement the confirmed design.

When additional signature changes are needed within the confirmed architecture and task scope, proceed and record the reasons. When the architecture or task scope needs to change, return to the corresponding design stage and wait for user direction.

After implementation, report the result and every signature change with their final orders beyond the final confirmed stage 2 and stage 3 designs.