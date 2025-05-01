{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = [
    (pkgs.lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ pkgs.gamescope pkgs.mangohud ];
    })
  ];
}
