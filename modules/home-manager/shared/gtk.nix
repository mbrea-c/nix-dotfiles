{ pkgs, ... }:
let
  _catpuccin-gtk-theme = {
    name = "catppuccin-macchiato-blue-standard";
    package = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ];
      size = "standard";
      variant = "macchiato";
    };
  };
in
{
  gtk = {
    enable = true;

    # Caelestia will manage gtk themes for now
    gtk2.theme = null;
    gtk3.theme = null;
    gtk4.theme = null;
    # Set back to catpuccin if I change my mind
    # gtk4.theme = catpuccin-gtk-theme;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin Macchiato Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    # Managed by caelestia
    # gtk3 = {
    #   extraConfig.gtk-application-prefer-dark-theme = true;
    # };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin Macchiato Dark";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };

  # Managed by caelestia
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     gtk-theme = "catppuccin-macchiato-blue-standard";
  #     color-scheme = "prefer-dark";
  #   };

  #   # For Gnome shell
  #   "org/gnome/shell/extensions/user-theme" = {
  #     name = "catppuccin-macchiato-blue-standard";
  #   };
  # };
}
