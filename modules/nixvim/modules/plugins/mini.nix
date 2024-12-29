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
            (lua # lua
              ''
                require('mini.map').gen_integration.diagnostic({
                  error = 'DiagnosticFloatingError',
                  warn  = 'DiagnosticFloatingWarn',
                  info  = 'DiagnosticFloatingInfo',
                  hint  = 'DiagnosticFloatingHint',
                })
              '')
          ];
          symbols = {
            scroll_view = "┊";
            encode = lua "require('mini.map').gen_encode_symbols.dot('4x2')";
          };
        };
      };
    };
  };
  keymaps = [{
    action = lua "MiniMap.toggle";
    key = "<leader>mm";
  }];
}
