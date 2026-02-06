{ nix-color-utils, ... }:
{ config, ... }:
let
  palette = config.dotcolors.palette;
in
{
  plugins = {
    lualine = {
      enable = true;
      settings = {
        tabline = { };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
            "buftype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [ "filename" ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [ "location" ];
        };
        extensions = [ ];
        options = {
          disabled_filetypes = { };
          component_separators = {
            left = "│";
            right = "│";
          };
          section_separators = {
            left = "▙";
            right = "▜";
          };
          icons_enabled = true;
          theme =
            let
              u = nix-color-utils.lib;
              colors = palette;
              out = u.compileNeovimColor;
              darken = u.color.hsvDarken;
            in
            {
              normal = {
                a = {
                  bg = out colors.color4;
                  fg = out colors.background;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.color7;
                };
                c = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.foreground;
                };
              };
              insert = {
                a = {
                  bg = out colors.color2;
                  fg = out colors.background;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.color4;
                };
              };
              command = {
                a = {
                  bg = out colors.color5;
                  fg = out colors.background;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.color5;
                };
              };
              visual = {
                a = {
                  bg = out colors.color6;
                  fg = out colors.background;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.color6;
                };
              };
              replace = {
                a = {
                  bg = out colors.color11;
                  fg = out colors.background;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.color11;
                };
              };
              inactive = {
                a = {
                  bg = out colors.background;
                  fg = out colors.color7;
                };
                b = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.foreground;
                  bold = true;
                };
                c = {
                  bg = out (darken 0.2 colors.background);
                  fg = out colors.foreground;
                };
              };
            };
        };
      };
    };
  };
}
