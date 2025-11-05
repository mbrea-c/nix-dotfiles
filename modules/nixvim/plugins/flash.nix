{ ... }:
let
  lua = l: { __raw = l; };
  desc = d: { desc = d; };
in {
  plugins = {
    flash = {
      enable = true;
      settings = { modes = { search = { enabled = false; }; }; };
    };
  };

  keymaps = [
    {
      mode = [ "c" ];
      key = "<C-f>";
      action = lua ''function() require("flash").toggle() end'';
      options = desc "Toggle flash during search";
    }
    {
      mode = [ "v" "n" "x" "o" ];
      key = "<C-/>";
      action = lua ''function() require("flash").jump() end'';
      desc = "Flash";
    }
  ];
}
