{ ... }: {
  plugins = {
    cmp-ai = {
      enable = true;
      settings = {
        max_lines = 10;
        provider = "Ollama";
        provider_options = { model = "codellama:7b-code"; };
        run_on_every_keystroke = true;
      };
    };
  };
}
