{ config, lib, pkgs, inputs, ... }:
{
    plugins.lsp = {
        enable = true;
        servers = {
            nil-ls.enable = true;
            rust-analyzer.enable = true;
        };
    };
}
