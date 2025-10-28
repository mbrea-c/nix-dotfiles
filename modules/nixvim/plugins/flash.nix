{ ... }:
let
  lua = l: { __raw = l; };
in
{
  plugins = {
    flash = {
      enable = true;
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = lua ''function() require("flash").jump() end'';
      desc = "Flash";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action = lua ''function() require("flash").treesitter() end'';
      desc = "Flash Treesitter";
    }
    # { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" }
    # { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" }
    # { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" }
  ];
}
