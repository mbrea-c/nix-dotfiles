{ pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    ubuntu-classic
    cascadia-code
    iosevka
    monoid
    nerd-fonts.iosevka
    nerd-fonts.monoid
    nerd-fonts.noto
    nerd-fonts.fira-code
    rubik
  ];

  # Fontconfig font fallbacks
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [
        "Rubik"
        "NotoSans Nerd Font"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
      ];
      monospace = [
        "Iosevka"
        "Iosevka Nerd Font"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
      ];
      serif = [
        "NotoSerif Nerd Font"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
      ];
    };
  };
}
