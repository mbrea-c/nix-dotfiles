{ inputs, colorscheme, ... }:
let
  u = inputs.nix-color-utils.lib;
  colors = u.fromBase16 colorscheme;
  inherit (u.hsv) lighten darken desaturate saturate highlight;
in {
  "@note" = {
    fg = colors.background;
    bg = colors.color5;
  };
  "@comment" = { fg = colors.color8; };
  "@comment.documentation" = {
    fg = lighten 0.2 colors.color8;
    italic = true;
  };
  "@warning" = {
    fg = colors.background;
    bg = colors.color5;
  };
  "@danger" = {
    fg = colors.background;
    bg = colors.color3;
  };
  "@constructor" = { fg = colors.color6; };
  "@conditional" = { fg = colors.color2; };
  "@constant" = {
    fg = darken 0.1 colors.color6;
    bold = true;
  };
  "@field" = { fg = darken 0.1 colors.color6; };
  "@function" = {
    fg = darken 0.2 colors.color2;
    bold = true;
  };
  "@keyword" = {
    fg = colors.color2;
    bold = true;
  };
  "@keyword.function" = {
    fg = darken 0.2 colors.color2;
    bold = true;
  };
  "@label" = { fg = colors.color7; };
  "@method" = {
    fg = colors.color6;
    bold = true;
  };
  "@namespace" = {
    fg = colors.color6;
    bold = true;
  };

  # Primitives
  "@number" = { fg = lighten 0.1 colors.color1; };
  "@float" = { fg = u.rgb.mix 0.5 colors.color1 colors.color6; };
  "@string" = { fg = colors.color1; };
  "@string.regex" = { fg = colors.color7; };
  "@string.escape" = { fg = colors.color6; };
  "@string.special.path" = { fg = colors.yellow; };
  "@boolean" = { fg = saturate 0.1 (darken 0.1 colors.color1); };

  "@operator" = {
    fg = colors.color3;
    bold = true;
  };
  "@parameter" = { fg = colors.color4; };
  "@property" = { fg = darken 0.1 colors.color6; };
  "@punctuation.delimiter" = { fg = darken 0.2 colors.color3; };
  "@punctuation.bracket" = {
    fg = highlight colorscheme 0.2 (desaturate 0.2 colors.color3);
  };
  "@punctuation.special" = { fg = colors.color3; };
  "@repeat" = { fg = colors.color2; };
  "@symbol" = { fg = darken 0.2 colors.foreground; };
  "@type" = { fg = colors.color2; };
  "@type.qualifier" = { fg = lighten 0.1 colors.color2; };
  "@type.builtin" = { fg = darken 0.1 colors.color2; };
  "@variable" = {
    fg = desaturate 0.1 (u.hsv.mix 0.5 colors.color4 colors.color6);
  };
  "@variable.builtin" = { fg = colors.color11; };
  "@text" = { fg = darken 0.1 colors.foreground; };
  "@text.emphasis" = { italic = true; };
  "@text.strong" = { bold = true; };
  "@text.underline" = { underline = true; };
  "@text.strike" = { strikethrough = true; };
  "@text.title" = {
    bold = true;
    underline = true;
  };
  "@text.literal" = { };
  "@text.uri" = {
    fg = darken 0.3 colors.color4;
    underline = true;
  };
  "@text.math" = { fg = colors.red; };
  "@text.reference" = { fg = colors.color8; };
  "@text.environment" = { fg = colors.color6; };
  "@text.environment.name" = { fg = colors.color6; };
  "@text.note" = { };
  "@text.warning" = { };
  "@text.danger" = { };
}
