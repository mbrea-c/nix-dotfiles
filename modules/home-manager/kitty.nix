{
  inputs,
  colorscheme,
  pkgs,
  ...
}:
let
  cu = inputs.nix-color-utils.lib.color;
  palette = inputs.nix-color-utils.lib.paletteFromNixColorsColorscheme colorscheme;
in
{
  home.packages = [ pkgs.kitty ];
  xdg.configFile = {
    "kitty/kitty.conf" = {
      text = ''
        font_family monospace
        confirm_os_window_close 2

        # Mappings
        clear_all_shortcuts yes

        # Colors
        cursor ${cu.hexstring palette.foreground}
        cursor_text_color background

        foreground ${cu.hexstring palette.foreground}
        background ${cu.hexstring palette.background}

        color0 ${cu.hexstring palette.color0}
        color1 ${cu.hexstring palette.color1}
        color2 ${cu.hexstring palette.color2}
        color3 ${cu.hexstring palette.color3}
        color4 ${cu.hexstring palette.color4}
        color5 ${cu.hexstring palette.color5}
        color6 ${cu.hexstring palette.color6}
        color7 ${cu.hexstring palette.color7}
        color8 ${cu.hexstring palette.color8}
        color9 ${cu.hexstring palette.color9}
        color10 ${cu.hexstring palette.color10}
        color11 ${cu.hexstring palette.color11}
        color12 ${cu.hexstring palette.color12}
        color13 ${cu.hexstring palette.color13}
        color14 ${cu.hexstring palette.color14}
        color15 ${cu.hexstring palette.color15}
      '';
      recursive = true;
    };
  };
}
