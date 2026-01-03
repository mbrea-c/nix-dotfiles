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
