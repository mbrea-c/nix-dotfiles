{ ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      permission = {
        "*" = "ask";
      };
    };
    tui = {
      theme = "system";
    };
  };
}
