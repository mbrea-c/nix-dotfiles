{ pkgs, ... }: [
  (pkgs.writeShellScriptBin "zeddit" (builtins.readFile ./sources/zeddit))
  (pkgs.writeShellScriptBin "show-colors"
    (builtins.readFile ./sources/show-colors))
  (pkgs.writeShellScriptBin "nxsh" (builtins.readFile ./sources/nxsh))
  (pkgs.writeShellApplication {
    name = "nixupd";
    runtimeInputs = [ pkgs.nvd ];
    text = builtins.readFile ./sources/nixupd;
  })
]
