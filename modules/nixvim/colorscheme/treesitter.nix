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
    fg = darken 0.1 colors.cyan;
    bold = true;
  };
  "@constant.builtin" = {
    fg = colors.cyan;
    bold = true;
  };
  "@field" = { fg = darken 0.1 colors.color6; };
  "@function" = {
    fg = darken 0.2 colors.blue;
    bold = true;
  };
  "@function.builtin" = {
    fg = colors.blue;
    bold = true;
  };
  "@keyword" = {
    fg = colors.green;
    bold = true;
  };
  "@keyword.function" = {
    fg = darken 0.2 colors.green;
    bold = true;
  };
  "@label" = { fg = colors.color7; };
  "@method" = {
    fg = colors.cyan;
    bold = true;
  };
  "@namespace" = {
    fg = darken 0.1 (desaturate 0.2 colors.cyan);
    bold = true;
  };
  "@module" = {
    fg = darken 0.1 (desaturate 0.2 colors.cyan);
    bold = true;
  };

  # Primitives
  "@number" = { fg = lighten 0.1 colors.color1; };
  "@number.float" = { fg = u.rgb.mix 0.5 colors.color1 colors.color6; };
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
  "@attribute" = { fg = colors.color5; };
  "@attribute.builtin" = { fg = darken 0.1 colors.color5; };
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

  "@markup.italic" = { italic = true; };
  "@markup.strong" = { bold = true; };
  "@markup.underline" = { underline = true; };
  "@markup.strikethrough" = { strikethrough = true; };
  "@markup.link" = { fg = colors.blue; };
  "@markup.link.label" = {
    fg = lighten 5.0e-2 (saturate 0.1 colors.blue);
    underline = true;
  };
  "@markup.link.url" = { fg = darken 0.2 colors.blue; };

  "@markup.heading" = {
    fg = lighten 0.15 colors.foreground;
    bold = true;
    underline = true;
    italic = true;
  };
  "@markup.list" = { fg = desaturate 0.2 colors.color3; };
  "@markup.raw" = { fg = saturate 0.15 colors.blue; };
  "@markup.raw.block" = { fg = saturate 0.2 colors.blue; };
  "@character.special" = { fg = colors.color5; };
}
