{ pkgs, ... }: {
  opts = { showtabline = 2; };
  extraPlugins = [{ plugin = pkgs.vimPlugins.tabby-nvim; }];
  extraConfigLua = builtins.readFile ./tabby.lua;
}
