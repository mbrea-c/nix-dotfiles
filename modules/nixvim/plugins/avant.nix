{ lib, avantSettings ? { }, ... }: {
  plugins = {
    avant = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate { } avantSettings;
    };
  };
}
