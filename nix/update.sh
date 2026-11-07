#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! git diff --quiet HEAD -- flake.nix; then
  echo "flake.nix has uncommitted changes. Commit them before updating." >&2
  exit 1
fi

nix flake update
sudo darwin-rebuild switch --flake .

if git diff --quiet HEAD -- flake.lock; then
  echo "flake.lock is unchanged, nothing to commit."
else
  git commit --only -m "chore(nix): update flake inputs" -- flake.lock
fi
