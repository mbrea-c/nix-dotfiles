{ ... }:
{
  plugins = {
    minuet = {
      enable = true;
      settings = {
        provider = "openai_fim_compatible";
        n_completions = 1;
        context_window = 512;
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM";
            name = "ollama";
            end_point = "http://localhost:11434/v1/completions";
            model = "qwen2.5-coder:3b";
            optional = {
              max_tokens = 56;
              top_p = 0.9;
            };
          };
        };
      };
    };
  };
}
