{ ... }: {
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {
            name = "copilot";
          }
          #{ name = "cmp_ai"; }
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        window = {
          completion = {
            col_offset = -3;
            side_padding = 0;
            border = "rounded";
          };
        };
        formatting = {
          fields = [ "abbr" "kind" "menu" ];
          format = # lua
            ''
              function(entry, vim_item)
                local kind_icons = {
                  Text = "",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "󰇽",
                  Variable = "󰂡",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈙",
                  Reference = "",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "󰅲",
                  Copilot = "",
                }
                local source_map = {
                  buffer = "[Buffer]",
                  nvim_lsp = "[LSP]",
                  luasnip = "[LuaSnip]",
                  nvim_lua = "[Lua]",
                  latex_symbols = "[LaTeX]",
                }

                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                if source_map[vim_item.menu] ~= nil then
                  vim_item.menu = source_map[vim_item.menu]
                end

                return vim_item
              end
            '';
        };
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = false })";
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
  };
}
