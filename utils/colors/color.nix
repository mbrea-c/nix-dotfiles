args@{ lib, inputs, ... }:
let util = (import ./util.nix) args;
in rec {
  # Constructors
  makeHsv = value: {
    variant = "hsv";
    value = value;
  };
  makeRgb = value: {
    variant = "rgb";
    value = value;
  };

  # Other operations
  isDark = { palette, ... }: (ensureHsv palette.base00).value.v < 0.5;

  # Conversion methods

  ensureHsv = color:
    if color.variant == "hsv" then
      color
    else
      (if color.variant == "rgb" then
        makeHsv (rgbToHsv color.value)
      else if color.variant == "hexrgb" then
        makeHsv (hexrgbToHsv color.value)
      else
        throw "invalid color variant: ${color.variant}");
  ensureRgb = color:
    if color.variant == "rgb" then
      color
    else
      (if color.variant == "hsv" then
        makeRgb (hsvToRgb color.value)
      else if color.variant == "hexrgb" then
        makeRgb (hexrgbToRgb color.value)
      else
        throw "invalid color variant: ${color.variant}");

  rgbToHsv = { r, g, b }:
    let
      max = util.listMax [ r g b ];
      min = util.listMin [ r g b ];
      d = max - min;
      v = max;
      s = if max > 0 then d / max else 0;
      h = (if max == 0 then
        0
      else if max == min then
        0
      else if max == r then
        (g - b) / d + (if g < b then 6 else 0)
      else if max == g then
        (b - r) / d + 2
      else
        (r - g) / d + 4) / 6;
    in { inherit h s v; };

  hsvToRgb = hsvValue:
    let
      i = builtins.floor (hsvValue.h * 6);
      f = hsvValue.h * 6 - i;
      p = hsvValue.v * (1 - hsvValue.s);
      q = hsvValue.v * (1 - f * hsvValue.s);
      t = hsvValue.v * (1 - (1 - f) * hsvValue.s);
      i' = lib.mod i 6; # Since we don't have a modulo operator
    in if i' == 0 then {
      r = hsvValue.v;
      g = t;
      b = p;
    } else if i' == 1 then {
      r = q;
      g = hsvValue.v;
      b = p;
    } else if i' == 2 then {
      r = p;
      g = hsvValue.v;
      b = t;
    } else if i' == 3 then {
      r = p;
      g = q;
      b = hsvValue.v;
    } else if i' == 4 then {
      r = t;
      g = p;
      b = hsvValue.v;
    } else {
      r = hsvValue.v;
      g = p;
      b = q;
    };
  hexrgbToRgb = hexrgbValue:
    let
      rgb = inputs.nix-colors.lib.conversions.hexToRGB hexrgbValue;
      r = util.byteToFloat (builtins.elemAt rgb 0);
      g = util.byteToFloat (builtins.elemAt rgb 1);
      b = util.byteToFloat (builtins.elemAt rgb 2);
    in { inherit r g b; };
  hexrgbToHsv = hexrgbValue: rgbToHsv (hexrgbToRgb hexrgbValue);

  rgbToHexrgb = rgbValue:
    let
      r = util.decToHex (util.floatToByte rgbValue.r);
      g = util.decToHex (util.floatToByte rgbValue.g);
      b = util.decToHex (util.floatToByte rgbValue.b);
    in "${r}${g}${b}";
  hsvToHexrgb = hsvValue: rgbToHexrgb (hsvToRgb hsvValue);
}
