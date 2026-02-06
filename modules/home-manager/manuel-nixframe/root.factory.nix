# This is a module factory
params:
{ ... }:
{
  imports = [ (import ../shared/personal-linux-common.factory.nix params) ];
}
