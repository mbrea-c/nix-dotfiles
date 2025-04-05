{ lib, ... }: rec {
  compose = fns: target:
    (lib.lists.foldr (fn: acc: target: fn (acc target)) (x: x) fns) target;
  attrsToList = attrs:
    lib.mapAttrsToList (key: value: { inherit key value; }) attrs;
  allFilesInDir = suffix: directory:
    compose [
      (builtins.map ({ key, ... }: directory + "/${key}"))
      (builtins.filter ({ key, ... }: lib.strings.hasSuffix suffix key))
      (builtins.filter ({ value, ... }: value == "regular"))
      attrsToList
    ] (builtins.readDir directory);
}
