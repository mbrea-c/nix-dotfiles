{ ... }: {
  programs = {
    rofi = {
      enable = true;
      extraConfig = { disable-history = true; };
    };
  };
}
