{ lib, avanteSettings ? { }, ... }: {
  plugins = {
    avante = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate {
        mappings = {
          diff = {
            next = "<leader><leader>>";
            prev = "<leader><leader><";
            none = "<leader><leader>c0";
            ours = "<leader><leader>co";
            theirs = "<leader><leader>ct";
            both = "<leader><leader>cb";
          };
        };
      } avanteSettings;
    };
  };
}
