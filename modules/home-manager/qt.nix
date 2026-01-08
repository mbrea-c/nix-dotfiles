{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qt5ct
    qt6ct
    breeze-qt5
    breeze-qt6
    breeze-icons
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
}
