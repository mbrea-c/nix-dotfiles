{ pkgs, ... }: {
  opts = { showtabline = 2; };
  extraPlugins = [{ plugin = pkgs.vimPlugins.tabby-nvim; }];
  extraConfigLua = import ./tabby.lua;
}
