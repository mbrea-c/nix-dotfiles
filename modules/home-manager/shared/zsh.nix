{ config, ... }:
let
  flakeRoot = ../../../.;
in
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
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
      glog = "git log --oneline";
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = "^[[B";
      searchUpKey = "^[[A";
    };
    initContent = (builtins.readFile (flakeRoot + /dotfiles/zshrc));
  };
}
