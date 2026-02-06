{ colorscheme, nix-color-utils, ... }:
{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=11";
      };
      colors =
        let
          col = nix-color-utils.lib.fromBase16 colorscheme;
        in
        {
          foreground = "${col.foreground}";
          background = "${col.background}";
          # cursor = {
          #   text = "#${col.background}";
          #   background = "#${col.foreground}";
          # };
          regular0 = "${col.black}";
          regular1 = "${col.red}";
          regular2 = "${col.green}";
          regular3 = "${col.yellow}";
          regular4 = "${col.blue}";
          regular5 = "${col.magenta}";
          regular6 = "${col.cyan}";
          regular7 = "${col.white}";
          bright0 = "${col.color8}";
          bright1 = "${col.color9}";
          bright2 = "${col.color10}";
          bright3 = "${col.color11}";
          bright4 = "${col.color12}";
          bright5 = "${col.color13}";
          bright6 = "${col.color14}";
          bright7 = "${col.color15}";

        };
    };
  };
}
