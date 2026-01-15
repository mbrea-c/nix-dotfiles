{ ... }:
{
  plugins = {
    flash = {
      enable = true;
      settings = {
        modes = {
          search = {
            enabled = false;
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "c" ];
      key = "<C-f>";
      action.__raw = ''function() require("flash").toggle() end'';
      options = {
        desc = "Toggle flash during search";
      };
    }
  ]
  ++ (map
    (key: {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = key;
      action.__raw = ''function() require("flash").jump() end'';
      options = {
        desc = "Flash";
      };
    })
    [
      "<C-/>"
      "<C-_>"
    ]
  );
}
