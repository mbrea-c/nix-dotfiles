{ inputs, colorscheme, pkgs, ... }: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nil-ls.enable = true;
        # nixd.enable = true;
        rust-analyzer = {
          enable = true;
          # We manage our own cargo versions with rustup
          installCargo = false;
          installRustc = false;
        };
        taplo.enable = true;
        bashls.enable = true;
        jsonls.enable = true;
        pyright.enable = true;
        marksman.enable = true;
      };
    };
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          nixfmt.enable = true;
          black.enable = true;
        };
      };
    };
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
    };
    # neo-tree.enable = true;
    dressing = { enable = true; };
    telescope = { enable = true; };
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
    lualine = {
      enable = true;
      iconsEnabled = true;
      componentSeparators = {
        left = "│";
        right = "│";
      };
      sectionSeparators = {
        left = "▙";
        right = "▜";
      };
      disabledFiletypes = { };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "encoding" "fileformat" "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      inactiveSections = {
        lualine_a = [ ];
        lualine_b = [ ];
        lualine_c = [ "filename" ];
        lualine_x = [ ];
        lualine_y = [ ];
        lualine_z = [ "location" ];
      };
      tabline = { };
      extensions = [ ];
      theme = let
        u = inputs.nix-color-utils.lib;
        colors = u.fromBase16 colorscheme;
        out = c: "#${c}";
        inherit (u.hsv) darken;
      in {
        normal = {
          a = {
            bg = out colors.color4;
            fg = out colors.background;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.color7;
          };
          c = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.foreground;
          };
        };
        insert = {
          a = {
            bg = out colors.color2;
            fg = out colors.background;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.color4;
          };
        };
        command = {
          a = {
            bg = out colors.color5;
            fg = out colors.background;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.color5;
          };
        };
        visual = {
          a = {
            bg = out colors.color6;
            fg = out colors.background;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.color6;
          };
        };
        replace = {
          a = {
            bg = out colors.color11;
            fg = out colors.background;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.color11;
          };
        };
        inactive = {
          a = {
            bg = out colors.background;
            fg = out colors.color7;
          };
          b = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.foreground;
            bold = true;
          };
          c = {
            bg = out (darken 0.2 colors.background);
            fg = out colors.foreground;
          };
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
