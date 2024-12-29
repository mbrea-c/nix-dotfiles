{ ... }: {
  plugins = {
    indent-blankline = {
      enable = true;
      settings = {
        indent = { char = " "; };
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
