{ ... }: {
  nushell = {
    enable = true;
    extraConfig = builtins.readFile ../../dotfiles/nushell/config.nu;

    shellAliases = {
      gst = "git status";
      vim = "nvim";
      glog = "git log --oneline";
    };
  };
}
