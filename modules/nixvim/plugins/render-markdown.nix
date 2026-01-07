{ ... }:
{
  plugins = {
    render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "markdown"
          "Avante"
          "codecompanion"
        ];
        render_modes = [
          "n"
          "no"
          "c"
          "t"
        ];
        anti_conceal = {
          enabled = false;
        };
        heading = {
          border = [
            true
            true
            false
          ];
          border_virtual = true;
          width = [
            "full"
            "full"
            "block"
          ];
          min_width = 30;
          position = "inline";
        };
        code = {
          sign = false;
          border = "thin";
          position = "right";
          width = "block";
          above = "▁";
          below = "▔";
          language_left = "█";
          language_right = "█";
          language_border = "▁";
          left_pad = 1;
          right_pad = 1;
        };
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>hm";
      action = "<cmd>RenderMarkdown buf_toggle<CR>";
      options = {
        desc = "Toggle markdown rendering in current buffer";
      };
    }
  ];
  custom.which-key.spec = [
    {
      __unkeyed-1 = "<leader>h";
      desc = "Highlight/rendering";
    }
  ];
}
