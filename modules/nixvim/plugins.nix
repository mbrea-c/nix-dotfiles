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
    neo-tree.enable = true;
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
        lua require("scrollbar").setup({ excluded_filetypes = { "neo-tree" } })
      '';
    }
  ];
}
