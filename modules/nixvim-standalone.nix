{ config, lib, pkgs, inputs, ... }:
{
    plugins.lsp = {
        enable = true;
        servers = {
            nil-ls.enable = true;
            rust-analyzer.enable = true;
        };
    };

    plugins.nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
        ];
    };
}
