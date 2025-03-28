{ ... }: {
  plugins = {
    cmp-ai = {
      enable = false;
      settings = {
        max_lines = 100;
        provider = "Ollama";
        provider_options = { model = "codellama:7b-code"; };
        run_on_every_keystroke = true;
      };
    };
  };
}
