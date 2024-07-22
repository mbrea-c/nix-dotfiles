{ pkgs, ... }: {
  home.packages = with pkgs; [ zsh-history-substring-search ];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      gst = "git status";
      vim = "nvim";
    };
    initExtra = (builtins.readFile ../../dotfiles/zshrc);
  };
}
