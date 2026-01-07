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
        anti-conceal = {
          enable = false;
        };
        heading = {
          border = true;
          border_virtual = true;
          width = [
            "full"
            "full"
            "block"
          ];
          min_width = 30;
        };
      };
    };
  };
}
