{ ... }:
{
  plugins = {
    render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "Avante"
          "codecompanion"
        ];
        render_modes = [
          "n"
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
}
