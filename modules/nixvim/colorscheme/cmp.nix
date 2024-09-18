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
    bg = colors.color8;
  };
  "CmpItemAbbrMatch" = { fg = colors.blue; };
  "CmpItemAbbrMatchFuzzy" = { fg = colors.blue; };
  "CmpItemMenu" = {
    fg = colors.green;
    italic = true;
  };
  "CmpItemKindVariable" = { bg = darken 0.3 colors.cyan; };
  "CmpItemKindInterface" = { bg = darken 0.3 colors.cyan; };
  "CmpItemKindText" = { bg = darken 0.2 colors.green; };
  "CmpItemKindFunction" = { bg = darken 0.2 colors.magenta; };
  "CmpItemKindMethod" = { bg = darken 0.2 colors.magenta; };
  "CmpItemKindKeyword" = { bg = darken 0.1 colors.green; };
  "CmpItemKindProperty" = { bg = darken 0.3 colors.cyan; };
  "CmpItemKindUnit" = { fg = colors.foreground; };
  "CmpItemKindSnippet" = { bg = darken 0.3 colors.green; };
  "CmpItemKindCopilot" = {
    bg = darken 0.3 (desaturate 0.3 (mix 0.5 colors.red colors.blue));
  };
  "CmpItemKindCodeium" = {
    bg = darken 0.3 (desaturate 0.3 (mix 0.5 colors.red colors.blue));
  };
}
