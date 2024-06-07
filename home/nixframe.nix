{ pkgs, ... }:
{
    home.username = "manuel";
    home.homeDirectory = "/home/manuel";
    home.packages = with pkgs; [
        firefox
        tree
        zed-editor
        nil
    ];

    xdg = {
      enable = true;
      userDirs = {
        createDirectories = true;

        desktop = "/home/manuel/Desktop";
        documents = "/home/manuel/Documents";
        download = "/home/manuel/Downloads";
        music = "/home/manuel/Music";
        pictures = "/home/manuel/Pictures";
        videos = "/home/manuel/Videos";
      };
    };

    # DO NOT CHANGE:
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    home.stateVersion = "24.05"; # Did you read the comment?

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Ubuntu"
        ];
      };
    };
}
