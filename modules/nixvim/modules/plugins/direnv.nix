{ config, ... }: {
  plugins = {
    direnv = {
      enable = true;
      settings = { input = { border = config.custom.border; }; };
    };
  };
}
