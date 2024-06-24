{ lib, ... }: {
  background = { palette, ... }: palette.base00;
  mapColors = lib.attrsets.mapAttrs (_: hl:
    lib.attrsets.mapAttrs
    (key: value: if key == "fg" || key == "bg" then "#${value}" else value));
}
