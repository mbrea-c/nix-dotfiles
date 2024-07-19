{ lib, colorscheme, inputs, ... }:
let
  u = inputs.nix-color-utils.lib;
  args = { inherit lib colorscheme inputs; };
in u.mapColors ((import ./colorscheme/base.nix args)
  // (import ./colorscheme/treesitter.nix args)
  // (import ./colorscheme/lsp-semantic-highlight.nix args)
  // (import ./colorscheme/diagnostic.nix args)
  // (import ./colorscheme/ibl.nix args)
  // (import ./colorscheme/file-trees.nix args)
  // (import ./colorscheme/git.nix args)
  // (import ./colorscheme/scrollbar.nix args))
