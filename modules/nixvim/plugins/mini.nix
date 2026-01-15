{ ... }:
{
  plugins = {
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = {
          style = "glyph";
        };
        map = {
          integrations = [
            { __raw = "require('mini.map').gen_integration.builtin_search()"; }
            {
              __raw =
                # lua
                ''
                  require('mini.map').gen_integration.diagnostic({
                    error = 'DiagnosticMiniError',
                    warn  = 'DiagnosticMiniWarn',
                    info  = 'DiagnosticMiniInfo',
                    hint  = 'DiagnosticMiniHint',
                  })
                '';
            }
          ];
          symbols = {
            scroll_view = "┊";
            encode.__raw = "require('mini.map').gen_encode_symbols.dot('4x2')";
          };
        };
      };
    };
  };
  keymaps = [
    {
      action.__raw = "MiniMap.toggle";
      key = "<leader>m";
    }
  ];
  # TODO: add aucmd group
  autoCmd = [
    {
      event = [ "VimEnter" ];
      callback.__raw = "MiniMap.open";
    }
    {
      event = [ "VimResized" ];
      callback.__raw = "MiniMap.refresh";
    }
  ];
}
