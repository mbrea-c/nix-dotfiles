{ lib, pkgs, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "indentmini";
  url = "https://github.com/nvimdev/indentmini.nvim";
  maintainers = [ "mbrea-c" ];
  package = lib.mkOption {
    type = lib.types.package;
    default = pkgs.vimUtils.buildVimPlugin {
      name = "indentmini";
      src = pkgs.fetchFromGitHub {
        owner = "nvimdev";
        repo = "indentmini.nvim";
        rev = "38572ce5a7a064a5deb89d6d861b7c40fc929ab1";
        hash = "sha256-bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=";
      };
    };
  };
}
