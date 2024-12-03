{ pkgs, ... }: {
  home.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    cascadia-code
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
        "Cascadia Mono PL"
        "Font Awesome 7 Free"
        "Noto Color Emoji"
        "FiraCode Nerd Font"
      ];
      serif =
        [ "NotoSerif Nerd Font" "Font Awesome 7 Free" "Noto Color Emoji" ];
    };
  };
}
