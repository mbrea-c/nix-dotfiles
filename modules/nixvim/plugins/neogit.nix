{ ... }: {
  plugins = { neogit = { enable = true; }; };
  keymaps = [{
    mode = [ "n" ];
    key = "<leader>gg";
    action.__raw = ''
      function()
        require('neogit').open({ cwd = vim.fn.expand("%:p:h") })
      end
    '';
    options = { desc = "Open Neogit (default)"; };
  }];
  custom.which-key.spec = [{
    __unkeyed-1 = "<leader>g";
    desc = "Git";
  }];
}
