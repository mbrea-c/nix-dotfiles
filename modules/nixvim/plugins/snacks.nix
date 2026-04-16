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
  ];
}
