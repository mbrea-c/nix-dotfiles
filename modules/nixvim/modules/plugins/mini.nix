{ ... }:
let lua = str: { __raw = str; };
in {
  plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = { style = "glyph"; };
        map = {
          integrations = [
            (lua "require('mini.map').gen_integration.builtin_search()")
            (lua "require('mini.map').gen_integration.diagnostic()")
          ];
        };
      };
    };
  };
  keymaps = [{
    action = lua "MiniMap.toggle";
    key = "<leader>mm";
  }];
}
