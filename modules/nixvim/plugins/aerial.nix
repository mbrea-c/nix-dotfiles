{ config, ... }:
let lu = (import ../../../utils/lua-utils.nix) { };
in {
  plugins = {
    aerial = {
      enable = true;
      settings = {
        nav = { preview = true; };
        autojump = true;
        highlight_on_jump = 600;
        layout = {
          max_width = [ 50 0.3 ];
          min_width = 50;
        };
        float = {
          border.__raw = lu.nixToLua config.custom.border;
          relative = "editor";
          max_height = 0.75;
          min_height = 0.75;
        };
      };
    };
  };
}
