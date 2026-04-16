{ ... }:
{
  plugins = {
    snacks = {
      enable = true;
      settings = {
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>sg";
      action.__raw = "function() Snacks.picker.grep() end";
      options = {
        desc = "Live grep in workspace";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>sf";
      action.__raw = "function() Snacks.picker.files() end";
      options = {
        desc = "Find files in workspace";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>sb";
      action.__raw = "function() Snacks.picker.buffers() end";
      options = {
        desc = "Find open buffers";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>ssw";
      action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
      options = {
        desc = "Find symbols in workspace";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>ssd";
      action.__raw = "function() Snacks.picker.lsp_symbols() end";
      options = {
        desc = "Find symbols in file";
      };
    }
  ];
  custom.which-key.spec = [
    {
      __unkeyed-1 = "<leader>s";
      desc = "Pickers";
    }
  ];
}
