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
    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-color-utils = {
      url = "github:mbrea-c/nix-color-utils";
      inputs.nix-colors.follows = "nix-colors";
    };
  };

  # ----------------------------------------------------------------------------

  outputs = { self, nixpkgs, ... }@inputs:
    let
      forSystems = (import ./utils/for-systems.nix) { lib = nixpkgs.lib; };
      makeSystem = import ./utils/make-system.nix;
    in forSystems [ "x86_64-linux" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
      in rec {
        nixosConfigurations.default = nixosConfigurations.nixframe;
        nixosConfigurations.nixframe = makeSystem {
          inherit inputs system;
          host = import ./hosts/nixframe.nix;
          home = import ./home/nixframe.nix;
        };
        nixosConfigurations.minikit = makeSystem {
          inherit inputs system;
          host = import ./hosts/minikit.nix;
          home = import ./home/minikit.nix;
        };

        devShells."${system}".rust-bevy-fhs =
          (import ./devenv/rust-bevy.nix) { inherit pkgs; };

        packages."${system}" = {
          manuvim =
            inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs colorscheme; };
              module = import ./modules/nixvim/manuvim.nix;
            };
        };

        homeManagerModules = {
          zsh = import ./modules/home-manager/zsh.nix;
          sway-vnc = import ./modules/home-manager/sway/sway-vnc.nix;
          fonts = import ./modules/home-manager/fonts.nix;
          foot = import ./modules/home-manager/foot.nix;
        };
        nixvimModules = { manuvim = import ./modules/nixvim/manuvim.nix; };

        lib = {
          combineNixvimModules = import ./modules/nixvim/helper-mod.nix;
        };
      });
}
