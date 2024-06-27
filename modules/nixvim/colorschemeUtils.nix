{ lib, inputs, ... }: 
let
  background = { palette, ... }: palette.base00;
  foreground = { palette, ... }: palette.base07;
  fromBase16 = { palette, ...}: rec {
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

  listMax = list:
    lib.foldl (a: b: if a > b then a else b) (builtins.elemAt list 0)
    list;
  listMin = list:
    lib.foldl (a: b: if a < b then a else b) (builtins.elemAt list 0)
    list;

  mapColors = lib.attrsets.mapAttrs (_: hl:
    lib.attrsets.mapAttrs
    (key: value: if key == "fg" || key == "bg" || key == "sp" then 
        "#${value}" 
        else 
        value) hl);

  # converts default nix-colors color (hex string such as "23F1AA") to the form
  # { r = 12; g = 255; b = 58 }.
  toRGB = color:
    let
      rgb = inputs.nix-colors.lib.conversions.hexToRGB color;
      r = builtins.elemAt rgb 0;
      g = builtins.elemAt rgb 1;
      b = builtins.elemAt rgb 2;
    in { inherit r g b; };

  toHSV = color:
    let
      c = toRGB color;
      r = c.r / 255.;
      g = c.g / 255.;
      b = c.b / 255.;
      max = listMax [ r g b ];
      min = listMin [ r g b ];
      d = max - min;
      v = max;
      s = if max > 0 then d / max else 0;
      h = (if max == 0 then 0 else
        if max == min then
          0
        else if max == r then
          (g - b) / d + (if g < b then 6 else 0)
        else if max == g then
          (b - r) / d + 2 
        else
          (r - g) / d + 4) 
        / 6;
    in { inherit h s v; };

  HSVToRGB = hsv: 
    let 
      i = builtins.floor(hsv.h * 6);
      f = hsv.h * 6 - i;
      p = hsv.v * (1 - hsv.s);
      q = hsv.v * (1 - f * hsv.s);
      t = hsv.v * (1 - (1 - f) * hsv.s);
      i' = lib.mod i 6; # Since we don't have a modulo operator

      rgb = if i' == 0 then
          { r = hsv.v; g = t; b = p; }
        else if i' == 1 then
          { r = q; g = hsv.v; b = p; }
        else if i' == 2 then
          { r = p; g = hsv.v; b = t; }
        else if i' == 3 then
          { r = p; g = q; b = hsv.v; }
        else if i' == 4 then
          { r = t; g = p; b = hsv.v; }
        else
          { r = hsv.v; g = p; b = q; };
    in {
      r = builtins.floor(rgb.r * 255 + 0.5);
      g = builtins.floor(rgb.g * 255 + 0.5);
      b = builtins.floor(rgb.b * 255 + 0.5);
    };

  decToHex = dec:
    let
      dHigh = dec / 16;
      dLow = lib.mod dec 16;
      intToHex = [
        "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
        "a" "b" "c" "d" "e" "f"
      ];
    in
      "${builtins.elemAt intToHex dHigh}${builtins.elemAt intToHex dLow}";

  fromRGB = rgb:
    let
      r = decToHex rgb.r;
      g = decToHex rgb.g;
      b = decToHex rgb.b;
    in "${r}${g}${b}";

  fromHSV = hsv: fromRGB (HSVToRGB hsv);

  darken = ratio: color:
    let
      hsv = toHSV color;
      ratio' = 1. - ratio;
    in fromHSV {
      h = hsv.h;
      s = hsv.s;
      v = hsv.v * ratio';
    };

  lighten = ratio: color: 
    let
      hsv = toHSV color;
      ratio' = 1. - ratio;
    in fromHSV {
        h = hsv.h;
        s = hsv.s;
        v = 1. - ratio' * (1. - hsv.v);
    };

  desaturate = ratio: color:
    let
      hsv = toHSV color;
      ratio' = 1. - ratio;
    in fromHSV {
      h = hsv.h;
      s = hsv.s * ratio';
      v = hsv.v;
    };

  saturate = ratio: color:
    let
      hsv = toHSV color;
      ratio' = 1. - ratio;
    in fromHSV {
      h = hsv.h;
      s = 1. - ratio' * (1. - hsv.s);
      v = hsv.v;
    };

  isDark = { palette, ... }:
    (toHSV palette.base00).v < 0.5;

  highlight = colorscheme: ratio: color:
    if isDark colorscheme then
      lighten ratio color
    else
      darken ratio color;
  
  # TODO: Fix when mixing around the boundary
  mixHSV = ratio: left: right:
    let
      leftHsv = toHSV left;
      rightHsv = toHSV right;
      maxHue = listMax [leftHsv.h rightHsv.h];
      minHue = listMin [leftHsv.h rightHsv.h];
      newHue = leftHsv.h * (1. - ratio) + rightHsv.h * ratio;
      newHue' = if 360. + minHue - maxHue < maxHue - minHue then
        if leftHsv.h == minHue then
          (360. + leftHsv.h) * (1. - ratio) + rightHsv.h * ratio
        else 
          leftHsv.h * (1. - ratio) + (360. + rightHsv.h) * ratio
        else newHue;
    in fromHSV {
      h = newHue';
      s = leftHsv.s * (1. - ratio) + rightHsv.s * ratio;
      v = leftHsv.v * (1. - ratio) + rightHsv.v * ratio;
    };
  mixRGB = ratio: left: right:
    let
      leftRgb = toRGB left;
      rightRgb = toRGB right;
    in fromRGB {
      r = builtins.floor ((1. - ratio) * leftRgb.r + ratio * rightRgb.r);
      g = builtins.floor ((1. - ratio) * leftRgb.g + ratio * rightRgb.g);
      b = builtins.floor ((1. - ratio) * leftRgb.b + ratio * rightRgb.b);
    };
in {
 inherit foreground background mapColors darken lighten 
  desaturate saturate highlight fromHSV toHSV mixHSV mixRGB
  fromBase16;
}
