{ ... }: {
  plugins = {
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = " ";
          highlight = [ "IblIndent" ];
        };
        scope = {
          enabled = true;
          char = "┃";
          show_start = false;
          show_end = false;
        };
      };
    };
  };
}
