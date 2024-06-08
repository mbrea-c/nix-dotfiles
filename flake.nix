{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        {
          nix.settings = {
            substituters = ["https://cosmic.cachix.org"];
            trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
          };
        }
        ./hosts/nixframe.nix
        inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useUserPackages = true;
          home-manager.users.manuel = {
            imports = [ ./home/nixframe.nix ];
          };
        }
      ];
    };
  };
}
