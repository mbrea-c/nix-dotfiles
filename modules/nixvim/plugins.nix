{ pkgs, ... }: {
  plugins = {
    markdown-preview = { enable = true; };
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
      };
    };
    treesitter = {
      enable = true;
      settings = { highlight.enable = true; };
    };
    nvim-tree = {
      enable = true;
      renderer = { groupEmpty = true; };
      diagnostics = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
      };
      git = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
      };
      updateFocusedFile = { enable = true; };
      view = { width = 50; };
      actions = { changeDir = { global = true; }; };
    };
    # neo-tree.enable = true;
    dressing = { enable = true; };
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
          show_end = false;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = aerial-nvim;
      config = ''
        lua require("aerial").setup({})
      '';
    }
    {
      plugin = nvim-scrollbar;
      config = ''
        lua require("scrollbar").setup({ excluded_filetypes = { "neo-tree", "nvim-tree" } })
      '';
    }
  ];
}
