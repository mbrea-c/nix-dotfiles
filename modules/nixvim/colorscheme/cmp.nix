{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;

  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) darken mix desaturate;
in {
  "PMenu" = { link = "NormalFloat"; };
  "CmpGhostText" = { fg = colors.color8; };
  "CmpItemAbbrDeprecated" = {
    strikethrough = true;
    fg = colors.color8;
  };
  "CmpItemAbbrMatch" = { fg = colors.blue; };
  "CmpItemAbbrMatchFuzzy" = { fg = colors.blue; };
  "CmpItemMenu" = {
    fg = colors.green;
    italic = true;
  };
  "CmpItemKindVariable" = { fg = darken 0.1 colors.cyan; };
  "CmpItemKindField" = { fg = darken 0.1 colors.cyan; };
  "CmpItemKindInterface" = { fg = darken 0.1 colors.cyan; };
  "CmpItemKindText" = { fg = darken 0.1 colors.green; };
  "CmpItemKindFunction" = { fg = darken 0.1 colors.magenta; };
  "CmpItemKindMethod" = { fg = darken 0.1 colors.magenta; };
  "CmpItemKindKeyword" = { fg = darken 0.1 colors.green; };
  "CmpItemKindProperty" = { fg = darken 0.1 colors.cyan; };
  "CmpItemKindUnit" = { fg = colors.foreground; };
  "CmpItemKindSnippet" = { fg = darken 0.1 colors.green; };
  "CmpItemKindCopilot" = {
    fg = darken 0.1 (desaturate 0.2 (mix 0.5 colors.red colors.blue));
  };
  "CmpItemKindCodeium" = {
    fg = darken 0.1 (desaturate 0.2 (mix 0.5 colors.red colors.blue));
  };
}
