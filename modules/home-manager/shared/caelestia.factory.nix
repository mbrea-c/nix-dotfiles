{ caelestia-shell, ... }:
{ pkgs, ... }:
{
  imports = [ caelestia-shell.homeManagerModules.default ];

  home.packages = with pkgs; [
    adw-gtk3
  ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "hyprland-session.target";
      environment = [ ];
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpapers";
      launcher = {
        vimKeybinds = true;
      };
      session = {
        vimKeybinds = true;
      };
      appearance = {
        rounding.scale = 0.5;
        font = {
          family = {
            clock = "sans-serif";
            material = "Material Symbols Rounded";
            mono = "monospace";
            sans = "sans-serif";
          };
        };
      };
      border = {
        rounding = 10;
      };
      services = {
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        smartScheme = true;
      };
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme = {
          enableTerm = false;
          enableGtk = true;
          enableQt = true;
        };
      };
    };
  };
}
