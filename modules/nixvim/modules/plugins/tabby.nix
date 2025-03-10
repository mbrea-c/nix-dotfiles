{ pkgs, ... }: {
  extraPlugins = [{
    config.__raw = # lua
      ''
        require('tabby').setup({})
      '';
    plugin = pkgs.vimPlugins.tabby-nvim;
  }];
}
