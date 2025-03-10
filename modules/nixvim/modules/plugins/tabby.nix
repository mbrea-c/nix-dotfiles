{ pkgs, ... }: {
  extraPlugins = [{ plugin = pkgs.vimPlugins.tabby-nvim; }];
  extraConfigLua = # lua
    ''
      require('tabby').setup({})
    '';
}
