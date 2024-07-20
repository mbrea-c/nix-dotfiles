{ ... }: {
  imports = builtins.trace "Loading a modules works" [ ./plugins/cmp.nix ];
}
