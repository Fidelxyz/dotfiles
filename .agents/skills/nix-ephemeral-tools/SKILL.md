---
name: nix-ephemeral-tools
description: Run a missing command from Nixpkgs with `nix run` or use `nix-shell` for a temporary tool environment, without installing packages into a system or user profile. Use when a needed CLI is absent and Nix is available.
---

# Temporary tools with Nix

Use Nix to run a needed tool without adding it to a system or user profile. Check whether the command or an existing project tool is already available first.

- **For one command**:

  ```sh
  nix run 'nixpkgs#package' [-- args...]
  ```

- **For several tools or commands that need a shared environment**:

  ```sh
  nix-shell -p package... --run 'command'
  ```

- **When an interactive shell is needed**:

  ```
  nix-shell -p package...
  ```

The package attribute and executable name can differ; check the package's main program when needed.
