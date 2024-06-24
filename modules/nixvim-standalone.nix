{ config, lib, pkgs, inputs, ... }:
let utils = (import ./nixvim/utils.nix) lib;
in {
  keymaps = [
    {
      key = "<C-n>";
      action = ":Neotree toggle<CR>";
    }
    {
      key = ";f";
      action = ":lua vim.lsp.buf.format()<CR>";
    }
  ];

  globals = {
    mapleader = ";";
    tex_flavor = "latex";
  };

  opts = {
    hidden = true;
    autoindent = true;

    # tabs
    tabstop = 4;
    shiftwidth = 0;
    softtabstop = 0;
    expandtab = true;

    # update time, used for CursorHold events
    updatetime = 250;

    # Spell checking
    spell = false; # disable by default
    spelllang = "en_us";

    number = true;
    display = "truncate";
    scrolloff = 5;
    sidescrolloff = 5;
    wrap = false;
    list = true;
    listchars = {
      tab = "  ";
      precedes = "⋯";
      extends = "⋯";
    };
    mouse = "a";
    mousemodel = "extend";
    textwidth = 80;
    #formatoptions = # somehow remove "t"?
    signcolumn = "yes:1";
    cursorline = true;
    #undofile = true;
    #TODO: undodir, etc
    ignorecase = true;
    smartcase = true;
    timeoutlen = 500;
    guifont = "monospace:h11";
  };

  autoCmd = utils.setTabstopForFiletypes {
    java = 4;
    solidity = 4;
    html = 2;
    javascript = 2;
    javascriptreact = 2;
    typescript = 2;
    json = 2;
    python = 2;
    lua = 2;
    agda = 2;
    markdown = 2;
    latex = 2;
    c = 4;
    cpp = 4;
    nix = 2;
  };

  plugins = {
    lsp = {
      enable = true;
      servers = {
        nil-ls.enable = true;
        rust-analyzer.enable = true;
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources =
        [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
    };
    none-ls = {
      enable = true;
      sources = { formatting = { nixfmt.enable = true; }; };
    };
    treesitter.enable = true;
    neo-tree.enable = true;
  };
}
