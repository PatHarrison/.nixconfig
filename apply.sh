#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------
# NixOS Modular Configuration Apply Script
# ----------------------------------------

# Location of your Nix flake root
FLAKE_ROOT="${HOME}/.nixconfig"

# Make sure the flake exists
if [ ! -f "${FLAKE_ROOT}/flake.nix" ]; then
    echo "Error: flake.nix not found in ${FLAKE_ROOT}"
    exit 1
fi

# Optional: Update flake inputs first
echo "Updating Nix flake inputs..."
nix flake update "${FLAKE_ROOT}" --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes'

# Build and switch to the new system configuration
echo "Applying NixOS configuration..."
sudo nixos-rebuild switch --flake "${FLAKE_ROOT}#odin" --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes'

# # Optional: Test configuration first without applying
# echo "Testing NixOS configuration..."
# sudo nixos-rebuild build --flake "${FLAKE_ROOT}#odin"

# Notify user
echo "NixOS configuration applied successfully!"
