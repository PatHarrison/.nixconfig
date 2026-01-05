#!/usr/bin/env bash

set -euo pipefail

# ----------------------------------------
# NixOS Modular Configuration Apply Script
# ----------------------------------------

# Location of your Nix flake root
FLAKE_ROOT="${HOME}/.nixconfig"
HOSTNAME=$(hostname)-steam

# Make sure the flake exists
if [ ! -f "${FLAKE_ROOT}/flake.nix" ]; then
    echo "Error: flake.nix not found in ${FLAKE_ROOT}"
    exit 1
fi

# Optional: Update flake inputs first
echo "Updating Nix flake inputs..."
sudo nix flake update --flake "${FLAKE_ROOT}"

# Build and switch to the new system configuration
echo "Applying NixOS configuration..."
sudo nixos-rebuild switch --flake "${FLAKE_ROOT}#$HOSTNAME"

# Notify user
echo "NixOS configuration applied successfully"
