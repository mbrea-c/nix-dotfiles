{ ... }:
let
  lua = l: { __raw = l; };
  desc = d: { desc = d; };
in
{
  plugins = {
    flash = {
      enable = true;
      settings = {
        modes = {
          search = {
            enabled = true;
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "c" ];
      key = "<C-f>";
      action = lua ''function() require("flash").toggle() end'';
      options = desc "Toggle flash during search";
    }
  ];
}
