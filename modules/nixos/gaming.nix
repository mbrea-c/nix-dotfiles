{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs;
    [
      (lutris.override {
        extraLibraries = pkgs: [ ];
        extraPkgs = pkgs: [ ];
      })
    ];
}
