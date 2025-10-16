{ ... }: {
  plugins = {
    telescope = {
      enable = true;
      extensions = { live-grep-args = { enable = true; }; };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<Up>".__raw = "require('telescope.actions').cycle_history_prev";
              "<Down>".__raw =
                "require('telescope.actions').cycle_history_next";
            };
            n = {
              "<Up>".__raw = "require('telescope.actions').cycle_history_prev";
              "<Down>".__raw =
                "require('telescope.actions').cycle_history_next";
            };
          };
        };
      };
    };
  };
}
