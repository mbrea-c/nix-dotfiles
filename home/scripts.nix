{ pkgs, ... }: [
  (pkgs.writeShellScriptBin "zeddit" (builtins.readFile ../scripts/zeddit))
  (pkgs.writeShellScriptBin "show-colors"
    (builtins.readFile ../scripts/show-colors))
]
