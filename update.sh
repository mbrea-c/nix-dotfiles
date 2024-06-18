#!/bin/sh

echo "UPDATING FLAKE..."
nix flake update
echo "Rebuild and switch..."
sudo nixos-rebuild switch --flake .#default
echo "CLOSURE DIFF..."
nix store diff-closures /run/booted-system /run/current-system
