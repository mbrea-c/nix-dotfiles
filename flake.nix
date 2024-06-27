{
  description = "Nixos config flake";

  # ----------------------------------------------------------------------------

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-color-utils = {
      url = "github:mbrea-c/nix-color-utils";
      inputs.nix-colors.follows = "nix-colors";
    };
  };

  # ----------------------------------------------------------------------------

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      colorscheme = inputs.nix-colors.colorSchemes.onedark;
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs colorscheme; };
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org" ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];
            };
          }
          ./hosts/nixframe.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs colorscheme; };
            home-manager.useUserPackages = true;
            home-manager.users.manuel = { imports = [ ./home/nixframe.nix ]; };
          }
        ];
      };
      devShells."${system}".rust-bevy-fhs =
        (import ./devenv/rust-bevy.nix) { inherit pkgs; };
    };
}
