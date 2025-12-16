#!/usr/bin/env bash

set -euo pipefail

echo "NixOS Cleanup Script"
echo "======================"
echo ""

# Remove old generations (keep last 3)
echo "Removing old system generations (keeping last 3)..."
sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

# Remove old home-manager generations (keep last 3)
echo "Removing old home-manager generations (keeping last 3)..."
nix-env --delete-generations +3 --profile ~/.local/state/nix/profiles/home-manager

# Collect garbage
echo " Collecting garbage..."
sudo nix-collect-garbage -d

# Optimize nix store
echo "Optimizing nix store..."
sudo nix-store --optimize

# Show disk space saved
echo ""
echo "Cleanup complete!"
echo ""
echo "Current /nix/store size:"
du -sh /nix/store
