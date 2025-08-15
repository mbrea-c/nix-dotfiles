{ ... }: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        # nixd.enable = true;
        rust_analyzer = {
          enable = true;
          # We manage our own cargo versions with rustup
          installCargo = false;
          installRustc = false;
        };
        wgsl_analyzer.enable = true;
        taplo.enable = true;
        bashls.enable = true;
        jsonls.enable = true;
        basedpyright.enable = true;
        marksman.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
        tinymist.enable = true;
        lua_ls.enable = true;
        kotlin_language_server = {
          enable = true;
          settings = { kotlin.formatting.formatter = "none"; };
        };
        metals.enable = true;
        nushell.enable = true;
        # Groovy LSP does not work
        # groovyls.enable = true;
      };
    };
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          nixfmt.enable = true;
          black.enable = true;
          ktlint = {
            enable = true;
            settings = { timeout = 50000; };
          };
          shfmt.enable = true;
          mdformat = {
            enable = true;
            settings = { extra_args = [ "--wrap" "80" ]; };
          };
          google_java_format.enable = true;
        };
        diagnostics = {
          checkstyle = {
            enable = true;
            settings = { extra_args = [ "-c" "/google_checks.xml" ]; };
          };
        };
      };
    };
  };

  keymaps = [{
    action = "<cmd>lua expand_macro_rust()<CR>";
    key = "<leader>rme";
  }];

  extraConfigLuaPre = ''
    function expand_macro_rust()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request_all(0, "rust-analyzer/expandMacro", params, function(results)
        for _, result in ipairs(results) do 
          if result.error then
            local err = result.error
            vim.notify("Error expanding macro" .. err.message, vim.log.levels.ERROR)
          end
          if result.result and result.result.expansion then
            local result = result.result
            local buf = vim.api.nvim_create_buf(false, true)  -- Create a new buffer, non-listed and scratch
            -- Set the lines (text) in the buffer
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result.expansion, '\n'))
            vim.api.nvim_set_option_value("filetype", "rust", {buf = buf})
            -- Define window options (position, size, etc.)
            local width = 80
            local height = 30 
            local opts = {
                style = "minimal",    -- "minimal" style to avoid extra UI elements
                relative = "editor",  -- Position relative to the editor
                width = width,
                height = height,
                row = (vim.o.lines - height) / 2,     -- Center the floating window vertically
                col = (vim.o.columns - width) / 2,    -- Center the floating window horizontally
                border = "rounded"    -- Rounded border for aesthetics
            }
            vim.api.nvim_open_win(buf, true, opts)
            return
          end
        end
      end)
    end
  '';
}
