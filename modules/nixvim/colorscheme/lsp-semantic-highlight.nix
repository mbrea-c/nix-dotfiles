{ inputs, palette, ... }:
let
  u = inputs.nix-color-utils.lib;
  mix = u.color.hsvMix;
in
{
  custom.colorscheme = {
    "@lsp.type.namespace" = {
      link = "@namespace";
    };
    "@lsp.type.comment" = {
      link = "@comment";
    };
    "@lsp.type.class" = {
      link = "@type";
    };
    "@lsp.type.enum" = {
      link = "@type";
    };
    "@lsp.type.interface" = {
      link = "@type";
    };
    "@lsp.type.struct" = {
      link = "@structure";
    };
    "@lsp.type.typeParameter" = {
      link = "@parameter";
    };
    "@lsp.type.parameter" = {
      link = "@parameter";
    };
    "@lsp.type.variable" = {
      link = "@variable";
    };
    "@lsp.type.property" = {
      link = "@property";
    };
    "@lsp.type.enumMember" = {
      link = "@constant";
    };
    "@lsp.type.event" = {
      link = "@method";
    };
    "@lsp.type.function" = {
      link = "@function";
    };
    "@lsp.type.method" = {
      link = "@method";
    };
    "@lsp.type.macro" = {
      link = "@macro";
    };
    "@lsp.type.keyword" = {
      link = "@keyword";
    };
    "@lsp.type.modifier" = {
      link = "@type.qualifier";
    };
    "@lsp.type.string" = {
      link = "@string";
    };
    "@lsp.type.number" = {
      link = "@number";
    };
    "@lsp.type.regexp" = {
      link = "@string.regex";
    };
    "@lsp.type.operator" = {
      link = "@operator";
    };
    "@lsp.type.decorator" = {
      link = "@attribute";
    };

    # Modifiers
    "@lsp.mod.deprecated" = {
      strikethrough = true;
    };
    "@lsp.mod.declaration" = {
      underdashed = true;
    };
    "@lsp.mod.readonly" = {
      italic = true;
    };
    "@lsp.mod.global" = {
      fg = mix 0.4 palette.red palette.yellow;
    };
    "@lsp.mod.attribute" = {
      link = "@attribute";
    };

    # Type/modifier combinations
    "@lsp.typemod.function.defaultLibrary" = {
      link = "@function.builtin";
    };
    "@lsp.typemod.comment.documentation" = {
      link = "@comment.documentation";
    };

    # Clangd specific
    "@lsp.mod.globalScope" = {
      link = "@lsp.mod.global";
    };
  };
}
