{ pkgs, ... }: [
  (pkgs.writeShellScriptBin "zeddit" (builtins.readFile ../scripts/zeddit))
  (pkgs.writeShellScriptBin "show-colors"
    (builtins.readFile ../scripts/show-colors))
  (pkgs.writeShellApplication {
    name = "nixupd";
    runtimeInputs = [ pkgs.nvd ];
    text = builtins.readFile ../scripts/nixupd;
  })
]
