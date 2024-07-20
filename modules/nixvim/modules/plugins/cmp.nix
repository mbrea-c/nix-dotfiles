{ ... }: {
  plugins = {
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
  };
}
