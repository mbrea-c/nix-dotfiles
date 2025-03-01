{
  description = "Template for a Pivot system";

  # ----------------------------------------------------------------------------

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-dotfiles = {
      url = "github:mbrea-c/nix-dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ----------------------------------------------------------------------------

  outputs = { self, nixpkgs, nix-dotfiles, ... }@inputs:
    let ndlib = nix-dotfiles.lib;
    in ndlib.forSystems [ "x86_64-linux" ] (system: rec {
      nixosConfigurations.default = nixosConfigurations.pivot;
      nixosConfiguration.pivot = ndlib.makeSystem {
        inherit inputs system;
        host = [ nix-dotfiles.nixosModules.pivot ./configuration.nix ];
      };
    });
}
