{ inputs, host ? [ ], home ? [ ], ... }:
let
  inherit (inputs) self nixpkgs;
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
in nixpkgs.lib.nixosSystem {
  specialArgs = { inherit self inputs colorscheme; };
  modules = host ++ (if builtins.length home > 0 then [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.extraSpecialArgs = { inherit inputs colorscheme self; };
      home-manager.useUserPackages = true;
      home-manager.users.manuel = { imports = home; };
    }
  ] else
    [ ]);
}
