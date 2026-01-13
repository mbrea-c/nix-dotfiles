{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  headingBg =
    { ... }:
    {
      fg = palette.background;
      bg = palette.color4 |> u.color.hsvSaturate 0.1 |> u.color.hsvLighten 0.1;
      bold = true;
      italic = false;
      underline = false;
    };
  heading =
    { ... }:
    {
      italic = false;
      underline = true;
      bold = true;
    };
in
{
  custom.colorscheme = {
    # These apply only to the icon
    "RenderMarkdownH1" = heading { };
    "RenderMarkdownH2" = heading { };
    "RenderMarkdownH3" = heading { };
    "RenderMarkdownH4" = heading { };
    "RenderMarkdownH5" = heading { };
    "RenderMarkdownH6" = heading { };
    # The "Bg" highlights extend through the entire line. The regular highlights don't
    "RenderMarkdownH1Bg" = headingBg { };
    "RenderMarkdownH2Bg" = headingBg { };
    "RenderMarkdownH3Bg" = headingBg { };
    "RenderMarkdownH4Bg" = headingBg { };
    "RenderMarkdownH5Bg" = headingBg { };
    "RenderMarkdownH6Bg" = headingBg { };

    "RenderMarkdownCode" = {
      bg = palette.blue |> u.color.hsvDesaturate 0.05 |> u.color.hsvDarken 0.75;
    };
    "RenderMarkdownCodeBorder" = {
      bg = palette.blue;
    };
    "RenderMarkdownQuote" = {
      bg = palette.blue;
    };
  };
}
