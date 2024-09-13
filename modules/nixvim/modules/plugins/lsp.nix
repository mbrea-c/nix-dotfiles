{ ... }: {
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
        basedpyright.enable = true;
        marksman.enable = true;
        tsserver.enable = true;
        cssls.enable = true;
      };
    };
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          nixfmt.enable = true;
          black.enable = true;
          mdformat = {
            enable = true;
            settings = { extra_args = [ "--wrap" "80" ]; };
          };
        };
      };
    };
  };
}
