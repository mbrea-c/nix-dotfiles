{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable32Bit = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  environment.systemPackages = [
    (pkgs.lutris.override {
      extraLibraries = pkgs: [ ];
      extraPkgs = pkgs: [ pkgs.gamescope pkgs.mangohud ];
    })
    (pkgs.heroic.override {
      extraPkgs = pkgs: [ pkgs.gamescope pkgs.mangohud ];
    })
  ];
}
