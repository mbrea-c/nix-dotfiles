# This is a module factory
params:
{ ... }:
let
  outputMaker = import ../../../utils/swayoutputmaker.nix;
in
{
  imports = [ (import ../shared/personal-linux-common.factory.nix params) ];
  swayx = {
    settings = {
      inherit
        (outputMaker {
          primary = "eDP-1";
          primaryScale = "1.3";
          secondary = "Dell Inc. DELL S2721DGF GV1KT83";
          secondaryScale = "1.0";
        })
        outputs
        workspaces
        ;
      dwt = true;
    };
  };
}
