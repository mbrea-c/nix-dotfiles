{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs;
    [
      (lutris.override {
        extraLibraries = pkgs: [ ];
        extraPkgs = pkgs: [ ];
      })
    ];
}
