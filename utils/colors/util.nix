{ lib, ... }: rec {
  fromBase16 = { palette, ... }: rec {
    color0 = palette.base00;
    color1 = palette.base08;
    color2 = palette.base0B;
    color3 = palette.base0A;
    color4 = palette.base0D;
    color5 = palette.base0E;
    color6 = palette.base0C;
    color7 = palette.base05;
    color8 = palette.base03;
    color9 = palette.base08;
    color10 = palette.base0B;
    color11 = palette.base0A;
    color12 = palette.base0D;
    color13 = palette.base0E;
    color14 = palette.base0C;
    color15 = palette.base07;
    foreground = color7;
    background = color0;
    black = color0;
    red = color1;
    green = color2;
    yellow = color3;
    blue = color4;
    magenta = color5;
    cyan = color6;
    white = color7;
    brightBlack = color8;
  };

  # Converts a float in [0,1] range to integer in [0,255] range
  floatToByte = float: builtins.floor (float * 255 + 0.5);
  # Converts an integer in [0,255] range to float in [0,1] range
  byteToFloat = byte: byte / 255.;
  byteToHex = dec:
    let
      dHigh = dec / 16;
      dLow = lib.mod dec 16;
      intToHex =
        [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f" ];
    in "${builtins.elemAt intToHex dHigh}${builtins.elemAt intToHex dLow}";

  listMax = list:
    builtins.foldl' (a: b: if a > b then a else b) (builtins.elemAt list 0)
    list;
  listMin = list:
    builtins.foldl' (a: b: if a < b then a else b) (builtins.elemAt list 0)
    list;

  mapColors = builtins.mapAttrs (_: hl:
    builtins.mapAttrs (key: value:
      if key == "fg" || key == "bg" || key == "sp" then "#${value}" else value)
    hl);

  toGtkCss = { palette, ... }:
    let
      colors = fromBase16 { inherit palette; };
      # css
    in ''
      @define-color foreground #${colors.foreground};
      @define-color background #${colors.background};

      @define-color color0  #${colors.color0};
      @define-color color1  #${colors.color1};
      @define-color color2  #${colors.color2};
      @define-color color3  #${colors.color3};
      @define-color color4  #${colors.color4};
      @define-color color5  #${colors.color5};
      @define-color color6  #${colors.color6};
      @define-color color7  #${colors.color7};
      @define-color color8  #${colors.color8};
      @define-color color9  #${colors.color9};
      @define-color color10 #${colors.color10};
      @define-color color11 #${colors.color11};
      @define-color color12 #${colors.color12};
      @define-color color13 #${colors.color13};
      @define-color color14 #${colors.color14};
      @define-color color15 #${colors.color15};
    '';
}
