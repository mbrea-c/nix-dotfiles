#!/bin/sh

colored() {
    color="$1"
    value="$2"

    color_code="30"
    case "$color" in
        red)
            color_code="31"
            ;;
        green)
            color_code="32"
            ;;
    esac

    echo -e "\e[${color_code};1m$value\e[0m"
}

read -p "Update flake? [Y/n]: " update_flake
if [ "$update_flake" = "Y" ]; then
    colored green "Updating flake..."
    nix flake update
fi
read -p "Commit everything? [Y/n]: " commit_everything
if [ "$commit_everything" = "Y" ]; then
    read -p "Commit message: " commit_message
    git add .
    git commit -m "$commit_message"
fi
colored green "Rebuild and switch..."
sudo nixos-rebuild switch --flake .#default
colored green "Closure diff since boot..."
nix store diff-closures /run/booted-system /run/current-system
