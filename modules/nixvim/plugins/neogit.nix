{ ... }: {
  plugins = { neogit = { enable = true; }; };
  keymaps = [{
    mode = [ "n" ];
    key = "<leader>gg";
    action.__raw = "require('neogit').open()";
    options = { desc = "Open Neogit (default)"; };
  }];
  custom.which-key.spec = [{
    __unkeyed-1 = "<leader>g";
    desc = "Git";
  }];
}
