{ ... }: {
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources =
          [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
        window = {
          completion = {
            col_offset = -3;
            side_padding = 0;
            border = "rounded";
          };
        };
        formatting = {
          fields = [ "kind" "abbr" "menu" ];
          # format = # lua
          #   ''
          #     function(entry, vim_item)
          #       local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          #       local strings = vim.split(kind.kind, "%s", { trimempty = true })
          #       kind.kind = " " .. (strings[1] or "") .. " "
          #       kind.menu = "    (" .. (strings[2] or "") .. ")"

          #       return kind
          #     end
          #   '';
        };
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
  };
}
