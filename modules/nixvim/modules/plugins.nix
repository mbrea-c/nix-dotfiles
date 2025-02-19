# This module just imports all of the active plugin modules
{ ... }: {
  imports = [
    # ./plugins/cmp.nix (currently replaced by blink)
    ./plugins/aerial.nix
    ./plugins/blink-cmp-copilot.nix
    ./plugins/blink.nix
    ./plugins/cmp-ai.nix
    ./plugins/copilot-lua.nix
    ./plugins/dap.nix
    ./plugins/diffview.nix
    ./plugins/direnv.nix
    ./plugins/dressing.nix
    ./plugins/gitsigns.nix
    ./plugins/indent-blankline.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/markdown-preview.nix
    ./plugins/mini.nix
    ./plugins/nvim-tree.nix
    ./plugins/telescope.nix
    ./plugins/toggleterm.nix
    ./plugins/treesitter.nix
    ./plugins/which-key.nix
  ];
}
