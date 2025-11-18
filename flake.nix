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
          # nixpkgs.config.allowUnfreePredicate = pkg:
          #   builtins.elem (lib.getName pkg) [ "grayjay" ];
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
          inherit inputs system pkgs;
          host = [ (import ./modules/nixos/hosts/nixframe.nix) ];
          home = [ (import ./modules/home-manager/config-roots/nixframe.nix) ];
        };
        nixosConfigurations.minikit = makeSystem {
          inherit inputs system pkgs;
          host = [ (import ./modules/nixos/hosts/minikit.nix) ];
          home = [ (import ./modules/home-manager/config-roots/minikit.nix) ];
        };
      }
    )
    // forSystems [ "x86_64-linux" "aarch64-darwin" ] (
      system:
      let
        pkgs = makePkgs system;
        colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
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
            extraSpecialArgs = { inherit inputs colorscheme; };
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
          pivot = import ./modules/nixos/hosts/pivot.nix;
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
