{ inputs, host, home, ... }:
let
  inherit (inputs) self nixpkgs;
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
in nixpkgs.lib.nixosSystem {
  specialArgs = { inherit self inputs colorscheme; };
  modules = [
    {
      nix.settings = {
        substituters = [ "https://cosmic.cachix.org" ];
        trusted-public-keys = [
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        ];
      };
    }
    host
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.extraSpecialArgs = { inherit inputs colorscheme self; };
      home-manager.useUserPackages = true;
      home-manager.users.manuel = { imports = [ home ]; };
    }
  ];
}
