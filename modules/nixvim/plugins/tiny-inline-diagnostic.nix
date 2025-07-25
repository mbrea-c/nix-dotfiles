{ ... }: {
  plugins = {
    tiny-inline-diagnostic = {
      enable = true;
      settings = {
        options = {
          show_source = {
            enabled = true;
            if_many = false;
          };
          multilines = {
            enabled = true;
            always_show = false;
          };
          show_all_diags_on_cursorline = true;
          use_icons_from_diagnostic = true;
          break_line = {
            enabled = true;
            after = 60;
          };
        };
      };
    };
  };
}
