{ ... }: {
  plugins = {
    toggleterm = {
      enable = true;
      settings = { shade_terminals = false; };
    };
  };

  keymaps = [{
    key = "<C-t>";
    action = "<cmd>ToggleTerm<CR>";
    mode = [ "n" "t" ];
  }];
}
