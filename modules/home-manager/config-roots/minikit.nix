{ ... }:
let outputMaker = import ../../../utils/swayoutputmaker.nix;
in {
  imports = [ ./personal-linux-common.nix ];
  swayx = {
    settings = {
      inherit (outputMaker {
        primary = "eDP-1";
        primaryScale = "1.3";
        secondary = "Dell Inc. DELL S2721DGF GV1KT83";
        secondaryScale = "1.0";
      })
        outputs workspaces;
      dwt = true;
    };
  };
}
