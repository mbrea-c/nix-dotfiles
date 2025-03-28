{ config, ... }: {
  plugins = {
    dressing = {
      enable = true;

      settings = { input = { border = config.custom.border; }; };
    };
  };
}
