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
          "__unkeyed-1.builtin_search" =
            (lua "require('mini.map').gen_integration.builtin_search()");
          "__unkeyed-2.diagnostic" =
            (lua "require('mini.map').gen_integration.diagnostic()");
        };
      };
    };
  };
}
