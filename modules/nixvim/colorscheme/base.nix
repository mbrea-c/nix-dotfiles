{ lib, inputs, colorscheme, ... }:
let
  u = (import ../colorschemeUtils.nix) { inherit lib inputs; };
  palette = colorscheme.palette;
  foreground = u.foreground colorscheme;
  background = u.background colorscheme;
in {
  "Normal" = {
    fg = foreground;
    bg = background;
  };
  "StatusLineNC" = {
    fg = background;
    bg = background;
  };
  "StatusLine" = {
    fg = background;
    bg = background;
  };
  "SignColumn" = {
    bg = u.darken 0.1 background;
    fg = background;
  };
  "MsgArea" = {
    fg = foreground;
    bg = background;
  };
  "ModeMsg" = {
    fg = foreground;
    bg = background;
  };
  "MsgSeparator" = {
    fg = foreground;
    bg = background;
  };
}
