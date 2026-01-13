{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  lighten = u.color.hsvLighten;
  darken = u.color.hsvDarken;
  desaturate = u.color.hsvDesaturate;
  saturate = u.color.hsvSaturate;
  hsvMix = u.color.hsvMix;
  rgbMix = u.color.rgbMix;
in
{
  custom.colorscheme = {
    "@note" = {
      fg = palette.background;
      bg = palette.color5;
    };
    "@comment" = {
      fg = palette.color8;
    };
    "@comment.documentation" = {
      fg = lighten 0.2 palette.color8;
      italic = true;
    };
    "@warning" = {
      fg = palette.background;
      bg = palette.color5;
    };
    "@danger" = {
      fg = palette.background;
      bg = palette.color3;
    };
    "@constructor" = {
      fg = palette.color6;
    };
    "@conditional" = {
      fg = palette.color2;
    };
    "@constant" = {
      fg = darken 0.1 palette.cyan;
      bold = true;
    };
    "@constant.builtin" = {
      fg = palette.cyan;
      bold = true;
    };
    "@field" = {
      fg = darken 0.1 palette.color6;
    };
    "@function" = {
      fg = darken 0.2 palette.blue;
      bold = true;
    };
    "@function.builtin" = {
      fg = palette.blue;
      bold = true;
    };
    "@keyword" = {
      fg = palette.green;
      bold = true;
    };
    "@keyword.function" = {
      fg = darken 0.2 palette.green;
      bold = true;
    };
    "@label" = {
      fg = palette.color7;
    };
    "@method" = {
      fg = palette.cyan;
      bold = true;
    };
    "@namespace" = {
      fg = darken 0.1 (desaturate 0.2 palette.cyan);
      bold = true;
    };
    "@module" = {
      fg = darken 0.1 (desaturate 0.2 palette.cyan);
      bold = true;
    };

    # Primitives
    "@number" = {
      fg = lighten 0.1 palette.color1;
    };
    "@number.float" = {
      fg = rgbMix 0.5 palette.color1 palette.color6;
    };
    "@string" = {
      fg = palette.color1;
    };
    "@string.regex" = {
      fg = palette.color7;
    };
    "@string.escape" = {
      fg = palette.color6;
    };
    "@string.special.path" = {
      fg = palette.yellow;
    };
    "@boolean" = {
      fg = saturate 0.1 (darken 0.1 palette.color1);
    };

    "@operator" = {
      fg = palette.color3;
      bold = true;
    };
    "@parameter" = {
      fg = palette.color4;
    };
    "@property" = {
      fg = darken 0.1 palette.color6;
    };
    "@punctuation.delimiter" = {
      fg = darken 0.2 palette.color3;
    };
    "@punctuation.bracket" = {
      fg = lighten 0.2 (desaturate 0.2 palette.color3);
    };
    "@punctuation.special" = {
      fg = palette.color3;
    };
    "@repeat" = {
      fg = palette.color2;
    };
    "@symbol" = {
      fg = darken 0.2 palette.foreground;
    };
    "@attribute" = {
      fg = palette.color5;
    };
    "@attribute.builtin" = {
      fg = darken 0.1 palette.color5;
    };
    "@type" = {
      fg = palette.color2;
    };
    "@type.qualifier" = {
      fg = lighten 0.1 palette.color2;
    };
    "@type.builtin" = {
      fg = darken 0.1 palette.color2;
    };
    "@variable" = {
      fg = desaturate 0.1 (hsvMix 0.5 palette.color4 palette.color6);
    };
    "@variable.builtin" = {
      fg = palette.color11;
    };
    "@text" = {
      fg = darken 0.1 palette.foreground;
    };
    "@text.emphasis" = {
      italic = true;
    };
    "@text.strong" = {
      bold = true;
    };
    "@text.underline" = {
      underline = true;
    };
    "@text.strike" = {
      strikethrough = true;
    };
    "@text.title" = {
      bold = true;
      underline = true;
    };
    "@text.literal" = { };
    "@text.uri" = {
      fg = darken 0.3 palette.color4;
      underline = true;
    };
    "@text.math" = {
      fg = palette.red;
    };
    "@text.reference" = {
      fg = palette.color8;
    };
    "@text.environment" = {
      fg = palette.color6;
    };
    "@text.environment.name" = {
      fg = palette.color6;
    };
    "@text.note" = { };
    "@text.warning" = { };
    "@text.danger" = { };

    "@markup.italic" = {
      italic = true;
    };
    "@markup.strong" = {
      bold = true;
    };
    "@markup.underline" = {
      underline = true;
    };
    "@markup.strikethrough" = {
      strikethrough = true;
    };
    "@markup.link" = {
      fg = palette.blue;
    };
    "@markup.link.label" = {
      fg = lighten 5.0e-2 (saturate 0.1 palette.blue);
      underline = true;
    };
    "@markup.link.url" = {
      fg = darken 0.2 palette.blue;
    };

    "@markup.heading" = {
      fg = lighten 0.15 palette.foreground;
      bold = true;
      underline = true;
      italic = true;
    };
    "@markup.list" = {
      fg = desaturate 0.2 palette.color3;
    };
    "@markup.raw" = {
      fg = saturate 0.15 palette.blue;
    };
    "@markup.raw.block" = {
      fg = saturate 0.2 palette.blue;
    };
    "@markup.quote" = {
      fg = palette.blue;
    };
    "@character.special" = {
      fg = palette.color5;
    };
  };
}
