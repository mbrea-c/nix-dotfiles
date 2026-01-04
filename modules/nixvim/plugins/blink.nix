{ config, ... }:
{
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
            window = {
              border = config.custom.border;
            };
          };
          ghost_text = {
            enabled = true;
          };
        };
        signature = {
          enabled = true;
          window = {
            border = config.custom.border;
          };
        };
        keymap = {
          "<C-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [ "hide" ];
          "<C-y>" = [ "select_and_accept" ];
          "<C-p>" = [
            "show"
            "select_prev"
            "fallback"
          ];
          "<C-n>" = [
            "show"
            "select_next"
            "fallback"
          ];
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<Tab>" = [
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];
        };
        sources = {
          default = [
            "minuet"
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          providers = {
            minuet = {
              async = true;
              module = "minuet.blink";
              name = "minuet";
              score_offset = 50;
              timeout_ms = 3000;
            };
          };
          #providers = {
          #  copilot = {
          #    async = true;
          #    module = "blink-cmp-copilot";
          #    name = "copilot";
          #    score_offset = 100;
          #  };
          #};
        };
        appearance = {
          kind_icons = {
            Copilot = "";
          };
        };
      };
    };
  };
}
