{ ... }: {
  plugins = {
    toggleterm = {
      enable = true;
      settings = { shade_terminals = false; };
    };
  };

  keymaps = [
    {
      key = "<C-t>";
      action = "<cmd>ToggleTerm<CR>";
      mode = [ "n" "t" ];
    }
    {
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<CR>";
      mode = [ "n" ];
    }
    {
      key = "<leader>tn";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Term name: "}, function(input)
            vim.cmd("TermNew name=" .. input)
          end)
        end
      '';
      mode = [ "n" ];
    }
    {
      key = "<leader>ts";
      action = "<cmd>TermSelect<CR>";
      mode = [ "n" ];
    }
  ];
  custom.which-key.spec = [{
    __unkeyed-1 = "<leader>t";
    desc = "Terminal management";
  }];
}
