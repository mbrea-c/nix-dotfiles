{ ... }: {
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

    # folds
    foldenable = false;

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
    formatoptions = "cqj"; # somehow remove "t"?
    signcolumn = "yes:1";
    cursorline = true;
    #undofile = true;
    #TODO: undodir, etc
    ignorecase = true;
    smartcase = true;
    timeoutlen = 500;
    guifont = "monospace:h11";
  };
  extraConfigLuaPre = # lua
    ''
      vim.diagnostic.config({ 
        virtual_text = false,
        virtual_lines = false,
      })
    '';
}
