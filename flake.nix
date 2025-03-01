{
  description = "Nixos config flake";

  # ----------------------------------------------------------------------------

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      # Removed in order to the following: 
      # https://nix-community.github.io/nixvim/user-guide/faq.html#how-do-i-solve-name-cannot-be-found-in-pkgs
      # inputs.nixpkgs.follows = "nixpkgs";
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

    blender-autorender = {
      url = "github:mbrea-c/blender-autorender";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ----------------------------------------------------------------------------

  outputs = { self, nixpkgs, ... }@inputs:
    let
      forSystems = self.outputs.lib.forSystems;
      makeSystem = self.outputs.lib.makeSystem;
    in forSystems [ "x86_64-linux" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
      in rec {
        nixosConfigurations.default = nixosConfigurations.nixframe;
        nixosConfigurations.nixframe = makeSystem {
          inherit inputs system;
          host = [ (import ./hosts/nixframe.nix) ];
          home = [ (import ./home/nixframe.nix) ];
        };
        nixosConfigurations.minikit = makeSystem {
          inherit inputs system;
          host = [ (import ./hosts/minikit.nix) ];
          home = [ (import ./home/minikit.nix) ];
        };

        devShells."${system}" =
          let shells = (import ./devenv/rust-bevy.nix) { inherit pkgs; };
          in {
            rust-bevy-fhs = shells.rust-bevy-fhs;
            rust-bevy = shells.rust-bevy;
          };

        packages."${system}" = {
          manuvim =
            inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs colorscheme; };
              module = import ./modules/nixvim/manuvim.nix;
            };
        };

        templates = {
          pivot = {
            path = ./templates/pivot;
            description = "Basic setup for the pivot system";
          };
        };

        nixosModules = { pivot = import hosts/pivot.nix; };
        homeManagerModules = {
          zsh = import ./modules/home-manager/zsh.nix;
          sway-vnc = import ./modules/home-manager/sway/sway-vnc.nix;
          fonts = import ./modules/home-manager/fonts.nix;
          foot = import ./modules/home-manager/foot.nix;
        };
        nixvimModules = { manuvim = import ./modules/nixvim/manuvim.nix; };

        lib = {
          combineNixvimModules = import ./modules/nixvim/helper-mod.nix;
          forSystems = (import ./utils/for-systems.nix) { lib = nixpkgs.lib; };
          makeSystem = import ./utils/make-system.nix;
        };
      });
}
