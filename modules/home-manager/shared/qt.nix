{ ... }:
{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  systemd.user.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
