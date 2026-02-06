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
    {
      self,
      nixpkgs,
      blender-autorender,
      nix-colors,
      nix-color-utils,
      ...
    }@inputs:
    let
      colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
      palette = inputs.nix-color-utils.lib.paletteFromNixColorsColorscheme colorscheme;
      moduleFactoryParams = {
        inherit
          blender-autorender
          nix-colors
          nix-color-utils
          colorscheme
          palette
          self
          ;
      };
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
        staticIp = ip: {
          staticIp = {
            staticIpv4 = ip;
            gatewayIpv4 = "192.168.1.254";
          };
        };
      in
      rec {
        nixosConfigurations.default = nixosConfigurations.nixframe;
        nixosConfigurations.nixframe = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [ (import ./modules/nixos/nixframe/root.factory.nix moduleFactoryParams) ];
          home = [ (import ./modules/home-manager/manuel-nixframe/root.factory.nix moduleFactoryParams) ];
        };
        nixosConfigurations.minikit = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [ (import ./modules/nixos/minikit/root.factory.nix moduleFactoryParams) ];
          home = [ (import ./modules/home-manager/manuel-minikit/root.factory.nix moduleFactoryParams) ];
        };
        nixosConfigurations.gitslayer = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [
            (import ./modules/nixos/gitslayer/root.nix)
            (staticIp "192.168.1.42")
          ];
        };
        nixosConfigurations.panopticon = makeSystem {
          inherit
            inputs
            system
            pkgs
            ;
          host = [
            (import ./modules/nixos/panopticon/root.nix)
            (staticIp "192.168.1.43")
          ];
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

        nixosModules = {
        };
        homeManagerModules = {
          zsh = import ./modules/home-manager/shared/zsh.nix;
          sway-vnc = import ./modules/home-manager/shared/sway/sway-vnc.nix moduleFactoryParams;
          fonts = import ./modules/home-manager/shared/fonts.nix;
          foot = import ./modules/home-manager/shared/foot.factory.nix moduleFactoryParams;
          my-firefox = import ./modules/home-manager/shared/my-firefox.nix;
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
