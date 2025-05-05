{ lib, avanteSettings ? { }, ... }: {
  plugins = {
    avante = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate { } avanteSettings;
    };
  };
}
