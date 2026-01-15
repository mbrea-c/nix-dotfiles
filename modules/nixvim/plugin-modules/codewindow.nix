{ lib, ... }:
lib.nixvim.plugins.mkNeovimPlugin {
  name = "codewindow";
  url = "https://github.com/gorbit99/codewindow.nvim";
  maintainers = [ "mbrea-c" ];
  package = "codewindow-nvim";
}
