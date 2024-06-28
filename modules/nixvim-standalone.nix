{ config, lib, pkgs, inputs, colorscheme, ... }:
let
  utils = (import ./nixvim/utils.nix) { inherit lib; };
  tabstopsAugroup = "TabstopForFiletypes";
  formattingEnablerAugroup = "FormatOnSaveForFiletypesEnabler";
  formattingFormatterAugroup = "FormatOnSaveForFiletypesFormatter";
  highlights =
    (import ./nixvim/colorscheme.nix) { inherit lib colorscheme inputs; };
in {
  keymaps = import ./nixvim/keymap.nix;

  highlightOverride = highlights;

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
    filetypes = {
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
    augroup = tabstopsAugroup;
  } ++ utils.setFormatOnSaveForFiletypes {
    filetypes = {
      nix = true;
      rust = true;
    };
    augroupEnabler = formattingEnablerAugroup;
    augroupFormatter = formattingFormatterAugroup;
  };

  autoGroups = {
    "${tabstopsAugroup}" = { clear = true; };
    "${formattingEnablerAugroup}" = { clear = true; };
    "${formattingFormatterAugroup}" = { clear = true; };
  };

  plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        rust-analyzer.enable = true;
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources =
          [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-n>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  cmp.complete()
                end
              end, { "i", "s" })
            '';
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<ESC>" = # lua
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.abort()
                  -- Emulate <Esc> keypress after exiting, so that you're not left in
                  -- insert mode
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
                else
                  fallback()
                end
              end, { "i", "c" })
            '';
        };
      };
    };
    none-ls = {
      enable = true;
      sources = { formatting = { nixfmt.enable = true; }; };
    };
    treesitter.enable = true;
    neo-tree.enable = true;
    dressing.enable = true;
    toggleterm = {
      enable = true;
      settings = { shade_terminals = false; };
    };
    indent-blankline = {
      enable = true;
      settings = {
        indent = { char = " "; };
        scope = {
          enabled = true;
          char = "┃";
          show_start = false;
        };
      };
    };
  };
}
