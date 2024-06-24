{ config, lib, pkgs, inputs, ... }:
{
    plugins.lsp = {
        enable = true;
        servers = {
            nil-ls.enable = true;
            rust-analyzer.enable = true;
        };
    };

    plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
        ];
    };

    plugins.none-ls = {
        enable = true;
        sources = {
            formatting = {
                nixfmt.enable = true;
            };
        };
    };

    plugins.treesitter.enable = true;
    plugins.neo-tree.enable = true;
}
