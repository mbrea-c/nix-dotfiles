{ lib, inputs, ... }: 
let
  background = { palette, ... }: palette.base00;
  foreground = { palette, ... }: palette.base07;

  listMax = list:
    lib.foldl (a: b: if a > b then a else b) (builtins.elemAt list 0)
    list;
  listMin = list:
    lib.foldl (a: b: if a < b then a else b) (builtins.elemAt list 0)
    list;

  mapColors = lib.attrsets.mapAttrs (_: hl:
    lib.attrsets.mapAttrs
    (key: value: if key == "fg" || key == "bg" then "#${value}" else value) hl);

  # converts default nix-colors color (hex string such as "23F1AA") to the form
  # { r = 12; g = 255; b = 58 }.
  toRGB = color:
    let
      rgb = inputs.nix-colors.lib.conversions.hexToRGB color;
      r = builtins.elemAt rgb 0;
      g = builtins.elemAt rgb 1;
      b = builtins.elemAt rgb 2;
    in { inherit r g b; };

  # test
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
in {
 inherit background mapColors darken lighten fromHSV toHSV;
}
