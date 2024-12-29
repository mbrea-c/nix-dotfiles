{ config, ... }: {
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        completion = {
          menu = {
            auto_show = true;
            border = config.custom.border;
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
            window = { border = config.custom.border; };
          };
          signature = {
            enabled = true;
            window = { border = config.custom.border; };
          };
          ghost_text = { enabled = true; };
        };
        keymap = {
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<C-e>" = [ "hide" ];
          "<C-y>" = [ "select_and_accept" ];
          "<C-p>" = [ "show" "select_prev" "fallback" ];
          "<C-n>" = [ "show" "select_next" "fallback" ];
          "<C-b>" = [ "scroll_documentation_up" "fallback" ];
          "<C-f>" = [ "scroll_documentation_down" "fallback" ];
          "<Tab>" = [ "snippet_forward" "fallback" ];
          "<S-Tab>" = [ "snippet_backward" "fallback" ];
        };
      };
    };
  };
}
