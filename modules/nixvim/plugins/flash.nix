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

  keymaps = [{
    mode = [ "c" ];
    key = "<C-f>";
    action = lua ''function() require("flash").toggle() end'';
    options = desc "Toggle flash during search";
  }] ++ (map (key: {
    mode = [ "n" "x" "o" ];
    key = key;
    action = lua ''function() require("flash").jump() end'';
    options = desc "Flash";
  }) [ "<C-/>" "<C-_>" ]);
}
