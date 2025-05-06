{ lib, avanteSettings ? { }, ... }: {
  plugins = {
    avante = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate {
        mappings = {
          ask = "<leader><leader>a";
          edit = "<leader><leader>e";
          refresh = "<leader><leader>r";
          focus = "<leader><leader>f";
          stop = "<leader><leader>S";
          toggle = {
            default = "<leader><leader>t";
            debug = "<leader><leader>d";
            hint = "<leader><leader>h";
            suggestion = "<leader><leader>s";
            repomap = "<leader><leader>R";
          };
          diff = {
            next = "g>";
            prev = "g<";
            none = "c0";
            ours = "co";
            theirs = "ct";
            both = "cb";
          };
        };
      } avanteSettings;

      luaConfig.pre = ''
        ${builtins.readFile ./avante_bedrock_keys.lua}
      '';
    };
  };
}
