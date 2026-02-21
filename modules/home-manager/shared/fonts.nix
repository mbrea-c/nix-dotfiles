{ pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    ubuntu-classic
    cascadia-code
    iosevka
    cozette
    nerd-fonts.noto
    nerd-fonts.fira-code
  ];

  # Fontconfig font fallbacks
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Ubuntu"
        "NotoSans Nerd Font"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
      ];
      monospace = [
        "CozetteVector"
        "Iosevka"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
        "FiraCode Nerd Font"
      ];
      serif = [
        "NotoSerif Nerd Font"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
      ];
    };
    configFile = {
      cozette = {
        enable = true;
        text = ''
          <?xml version="1.0"?>
          <fontconfig>
            <match target="font">
              <test name="family">
                <string>CozetteVector</string>
              </test>
              <edit name="antialias" mode="assign">
                <bool>false</bool>
              </edit>
            </match>
          </fontconfig>
        '';
      };
    };
  };
}
