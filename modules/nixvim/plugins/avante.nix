{ ... }: {
  plugins = {
    avante = {
      enable = false;
      settings = {
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
          files = {
            add_current = "<leader><leader>c";
            add_all_buffers = "<leader><leader>B";
          };
          select_model = "<leader><leader>?";
          select_history = "<leader><leader>h";

          diff = {
            next = "g>";
            prev = "g<";
            none = "c0";
            ours = "co";
            theirs = "ct";
            both = "cb";
          };
        };
      };

      luaConfig.pre = ''
        ${builtins.readFile ./avante_bedrock_keys.lua}
      '';

      lazyLoad = {
        enable = true;
        settings = { cmd = "AvanteLoad"; };
      };
    };
  };
}
