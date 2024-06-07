#!/bin/sh

echo "UPDATING FLAKE..."
nix flake update
echo "Rebuild and switch..."
sudo nixos-rebuild switch --flake .#default
