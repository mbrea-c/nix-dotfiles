#!/bin/bash

DISK_NAME="main"
DISK_DEVICE="$1"

nixos-generate-config --root . --no-filesystems
mv ./etc/nixos/{configuration,hardware-configuration}.nix ./
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake .#pivot --disk "$DISK_NAME" "$DISK_DEVICE"
