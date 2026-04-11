{ ... }:
{
  programs.swayimg = {
    enable = true;
    settings = {
      "keys.viewer" = {
        # vim-style panning
        h = "step_left";
        j = "step_down";
        k = "step_up";
        l = "step_right";
      };
    };
  };
}
