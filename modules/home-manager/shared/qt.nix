{ ... }:
{
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  systemd.user.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
