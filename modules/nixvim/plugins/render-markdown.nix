{ pkgs, ... }:
{
  plugins = {
    render-markdown = {
      enable = true;
      settings = {
        file_types = [
          "markdown"
          "Avante"
          "codecompanion"
        ];
        render_modes = [
          "n"
          "no"
          "c"
          "t"
        ];
        anti_conceal = {
          enabled = true;
          above = 0;
          below = 0;
        };
        heading = {
          border = [
            true
            false
          ];
          border_virtual = true;
          width = [
            "full"
            "full"
            "block"
          ];
          icons.__raw = ''
            function(context)
              local indices = table.concat(context.sections, ".")
              return "󰫎 " .. indices .. ". "
            end
          '';
          min_width = 30;
          position = "inline";
          sign = false;
        };
        code = {
          sign = false;
          border = "thick";
          position = "left";
          width = "full";
          above = "▁";
          below = "▔";
          language_left = "█";
          language_right = "█";
          language_border = "▁";
          left_pad = 0;
          right_pad = 0;
        };
        overrides = {
          buftype = {
            nofile = false;
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>hm";
      action = "<cmd>RenderMarkdown buf_toggle<CR>";
      options = {
        desc = "Toggle markdown rendering in current buffer";
      };
    }
  ];
  custom.which-key.spec = [
    {
      __unkeyed-1 = "<leader>h";
      desc = "Highlight/rendering";
    }
  ];
  extraPackages = [
    pkgs.python313Packages.pylatexenc
  ];
}
