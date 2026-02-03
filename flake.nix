{
  description = "Nixos config flake";

  # ----------------------------------------------------------------------------

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";

    nix-color-utils = {
      url = "github:mbrea-c/nix-color-utils";
      inputs.nix-colors.follows = "nix-colors";
    };

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

    blender-autorender = {
      url = "github:mbrea-c/blender-autorender";
      # This package is pretty fragile so we shouldn't follow nixpkgs on it
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ----------------------------------------------------------------------------

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      forSystems = (import ./utils/for-systems.nix) { lib = nixpkgs.lib; };
      makeSystem = import ./utils/make-system.nix;
      makePkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ inputs.nur.overlays.default ];
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        };
    in
    (
      let
        system = "x86_64-linux";
        pkgs = makePkgs system;
      in
      rec {
        nixosConfigurations.default = nixosConfigurations.nixframe;
        nixosConfigurations.nixframe = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [ (import ./modules/nixos/nixframe/root.nix) ];
          home = [ (import ./modules/home-manager/config-roots/nixframe.nix) ];
        };
        nixosConfigurations.minikit = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [ (import ./modules/nixos/minikit/root.nix) ];
          home = [ (import ./modules/home-manager/config-roots/minikit.nix) ];
        };
        nixosConfigurations.gitslayer = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [ (import ./modules/nixos/gitslayer/root.nix) ];
        };
      }
    )
    // forSystems [ "x86_64-linux" "aarch64-darwin" ] (
      system:
      let
        pkgs = makePkgs system;
        colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
        palette = inputs.nix-color-utils.lib.paletteFromNixColorsColorscheme colorscheme;
      in
      {
        devShells."${system}" =
          let
            shells = (import ./devenv/rust-bevy.nix) { inherit pkgs; };
          in
          {
            rust-bevy-fhs = shells.rust-bevy-fhs;
            rust-bevy = shells.rust-bevy;
          };

        packages."${system}" = {
          manuvim = inputs.nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
            inherit pkgs;
            extraSpecialArgs = {
              inherit
                inputs
                palette
                ;
            };
            module = import ./modules/nixvim/manuvim.nix;
          };
          tracy = pkgs.callPackage ./pkgs/tracy { };
          kotlin-lsp = pkgs.callPackage ./pkgs/kotlin-lsp { };
        };

        templates = {
          pivot = {
            path = ./templates/pivot;
            description = "Basic setup for the pivot system";
          };
        };

        nixosModules = {
        };
        homeManagerModules = {
          zsh = import ./modules/home-manager/zsh.nix;
          sway-vnc = import ./modules/home-manager/sway/sway-vnc.nix;
          fonts = import ./modules/home-manager/fonts.nix;
          foot = import ./modules/home-manager/foot.nix;
          my-firefox = import ./modules/home-manager/my-firefox.nix;
        };
        nixvimModules = {
          manuvim = import ./modules/nixvim/manuvim.nix;
        };

        lib = {
          combineNixvimModules = import ./modules/nixvim/helper-mod.nix;
          forSystems = forSystems;
          makeSystem = makeSystem;
        };
      }
    );
}
