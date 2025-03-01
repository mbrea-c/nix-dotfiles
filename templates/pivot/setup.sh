#!/bin/bash

DISK_NAME="main"
DISK_DEVICE="$1"

# get configs ready
nixos-generate-config --root . --no-filesystems
mv ./etc/nixos/{configuration,hardware-configuration}.nix ./

# mount stuff
sudo nix --experimental-features "nix-command flakes" run "github:nix-community/disko/latest" -- --flake .#pivot --arg diskMappings "{ \"${DISK_NAME}\" = \"${DISK_DEVICE}\"; }" --mode destroy,format,mount

sudo nixos-install --flake .#pivot
