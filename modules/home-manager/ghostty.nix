{ inputs, colorscheme, ... }: {

  programs.ghostty = {
    enable = true;
    settings = let col = inputs.nix-color-utils.lib.fromBase16 colorscheme;
    in {
      font-family = "monospace";
      font-size = "11pt";
      background = "#${col.background}";
      foreground = "#${col.foreground}";
      palette = [
        "0=${col.color0}"
        "1=${col.color1}"
        "2=${col.color2}"
        "3=${col.color3}"
        "4=${col.color4}"
        "5=${col.color5}"
        "6=${col.color6}"
        "7=${col.color7}"
        "8=${col.color8}"
        "9=${col.color9}"
        "10=${col.color10}"
        "11=${col.color11}"
        "12=${col.color12}"
        "13=${col.color13}"
        "14=${col.color14}"
        "15=${col.color15}"
      ];
      ######################################################################
      # colors =
      # in {
      #   primary = {  };
      #   cursor = {
      #     text = "#${col.background}";
      #     background = "#${col.foreground}";
      #   };
      #   normal = {
      #     black = "#${col.black}";
      #     red = "#${col.red}";
      #     green = "#${col.green}";
      #     yellow = "#${col.yellow}";
      #     blue = "#${col.blue}";
      #     magenta = "#${col.magenta}";
      #     cyan = "#${col.cyan}";
      #     white = "#${col.white}";
      #   };
      #   bright = {
      #     black = "#${col.color8}";
      #     red = "#${col.color9}";
      #     green = "#${col.color10}";
      #     yellow = "#${col.color11}";
      #     blue = "#${col.color12}";
      #     magenta = "#${col.color13}";
      #     cyan = "#${col.color14}";
      #     white = "#${col.color15}";
      #   };
      # };
    };
  };
}
