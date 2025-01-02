{ config, ... }: {
  plugins = {
    aerial = {
      enable = true;
      settings = {
        nav = { preview = true; };
        autojump = true;
        highlight_on_jump = 600;
        layout = {
          max_width = [ 50 0.3 ];
          min_width = 50;
        };
        float = {
          border = config.custom.border;
          relative = "editor";
          max_height = 0.75;
          min_height = 0.75;
        };
      };
    };
  };
}
