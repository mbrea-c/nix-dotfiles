{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
