{ config, ... }: {
  plugins = {
    direnv = {
      enable = true;
      settings = { input = { border = config.border; }; };
    };
  };
}
