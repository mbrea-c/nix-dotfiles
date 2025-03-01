#!/bin/bash

DISK_NAME="main"
DISK_DEVICE="$1"

nixos-generate-config --root . --no-filesystems
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#pivot --disk "$DISK_NAME" "$DISK_DEVICE"
