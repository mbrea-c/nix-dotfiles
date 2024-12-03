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
        taplo.enable = true;
        bashls.enable = true;
        jsonls.enable = true;
        # basedpyright is too strict TODO: Maybe figure out how to configure
        pyright.enable = true;
        marksman.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
        typst_lsp.enable = true;
        lua_ls.enable = true;
        kotlin_language_server.enable = true;
      };
    };
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          nixfmt.enable = true;
          black.enable = true;
          ktlint.enable = true;
          mdformat = {
            enable = true;
            settings = { extra_args = [ "--wrap" "80" ]; };
          };
        };
      };
    };
  };
}
