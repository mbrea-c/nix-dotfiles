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
            icons = {
              chat_context = "📎️";
            };
            fold_context = true;
            window = {
              layout = "vertical";
              position = "right";
            };
          };
          inline = {
            adapter = quen3b-adapter;
          };
          cmd = {
            adapter = quen3b-adapter;
          };
          background = {
            adapter = quen3b-adapter;
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
        desc = "Live grep in workspace";
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
