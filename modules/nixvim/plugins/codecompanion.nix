{ ... }:
let
  quen3b-adapter = {
    name = "ollama";
    model = "qwen3:8b";
  };
in {
  plugins = {
    codecompanion = {
      enable = true;
      settings = {
        interactions = {
          chat = {
            adapter = quen3b-adapter;
            icons = { chat_context = "📎️"; };
            fold_context = true;
            window = {
              layout = "vertical";
              position = "right";
            };
          };
          inline = { adapter = quen3b-adapter; };
          cmd = { adapter = quen3b-adapter; };
          background = { adapter = quen3b-adapter; };
        };
      };
    };
  };
}
