{ ... }:
let
  quen3b-adapter = {
    name = "ollama";
    model = "qwen3:8b";
  };
in
{
  plugins = {
    codecompanion = {
      enable = true;
      settings = {
        interactions = {
          chat = {
            adapter = quen3b-adapter;
          };
          inline = {
            adapter = quen3b-adapter;
          };
          cmd = {
            adapter = quen3b-adapter;
          };
          background = {
            adapter = quen3b-adapter;
            chat = {
              callbacks = {
                on_ready = {
                  actions = [
                    "interactions.background.builtin.chat_make_title"
                  ];
                  enabled = true;
                };
              };
              opts = {
                enabled = true;
              };
            };

          };
        };
        display = {
          chat = {
            icons = {
              chat_context = "📎️";
            };
            fold_context = true;
            window = {
              position = "right";
            };
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader><leader>c";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      options = {
        desc = "Toggle chat";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader><leader><leader>";
      action = "<cmd>CodeCompanionActions<CR>";
      options = {
        desc = "Action menu";
      };
    }
  ];
  custom.which-key.spec = [
    {
      __unkeyed-1 = "<leader><leader>";
      desc = "✨AI slop✨";
    }
  ];
}
