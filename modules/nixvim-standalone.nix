{ lib, pkgs, inputs, colorscheme, ... }:
let
  utils = (import ./nixvim/utils.nix) { inherit lib; };
  tabstopsAugroup = "TabstopForFiletypes";
  formattingEnablerAugroup = "FormatOnSaveForFiletypesEnabler";
  formattingFormatterAugroup = "FormatOnSaveForFiletypesFormatter";
  highlights =
    (import ./nixvim/colorscheme.nix) { inherit lib colorscheme inputs; };
  plugins = (import ./nixvim/plugins.nix) { inherit pkgs inputs colorscheme; };
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
      toml = true;
    };
    augroupEnabler = formattingEnablerAugroup;
    augroupFormatter = formattingFormatterAugroup;
  };

  autoGroups = {
    "${tabstopsAugroup}" = { clear = true; };
    "${formattingEnablerAugroup}" = { clear = true; };
    "${formattingFormatterAugroup}" = { clear = true; };
  };

  plugins = plugins.plugins;
  extraPlugins = plugins.extraPlugins;
}
