{ ... }: {
  plugins = {
    nvim-tree = {
      enable = true;
      settings = {
        renderer = {
          group_empty = true;
          highlight_opened_files = "all";
          indent_markers = { enable = true; };
        };
        diagnostics = {
          enable = true;
          show_on_dirs = true;
          show_on_open_dirs = false;
        };
        git = {
          enable = true;
          show_on_dirs = true;
          show_on_open_dirs = false;
        };
        update_focused_file = { enable = true; };
        view = { width = 50; };
        actions = { change_dir = { global = true; }; };
      };
    };
  };
}
