{ config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.nginx = {
    enable = true;
    virtualHosts."_default_" = {
      listen = [
        {
          addr = config.gitslayer.staticIpv4;
          port = 80;
        }
      ];
      forceSSL = false;
      enableACME = false;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://localhost:${toString srv.HTTP_PORT}";
    };
  };

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      DEFAULT = {
        APP_NAME = "GitSlayer";
      };
      server = {
        DOMAIN = config.gitslayer.staticIpv4;
        PROTOCOL = "http";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "http://${config.gitslayer.staticIpv4}/";
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = false;
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      # Sending emails is completely optional
      # You can send a test email from the web UI at:
      # Profile Picture > Site Administration > Configuration >  Mailer Configuration
      mailer = {
        ENABLED = false;
        SMTP_ADDR = "mail.example.com";
        FROM = "noreply@${srv.DOMAIN}";
        USER = "noreply@${srv.DOMAIN}";
      };
      ui = {
        DEFAULT_THEME = "custom";
        THEMES = "forgejo-auto,forgejo-light,forgejo-dark,custom";
      };
    };
    # mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
  };

  systemd.tmpfiles.rules =
    let
      icon = ./doomgrin.png;
      css = ./forgejo-theme.css;
    in
    [
      # directory structure
      "d '${cfg.customDir}/public' 0750 ${cfg.user} ${cfg.group} - -"
      "d '${cfg.customDir}/public/assets' 0750 ${cfg.user} ${cfg.group} - -"
      "d '${cfg.customDir}/public/assets/img' 0750 ${cfg.user} ${cfg.group} - -"
      "d '${cfg.customDir}/public/assets/css' 0750 ${cfg.user} ${cfg.group} - -"

      # reuse the same PNG everywhere
      "L+ '${cfg.customDir}/public/assets/img/logo.png' - - - - ${icon}"
      "L+ '${cfg.customDir}/public/assets/img/logo.svg' - - - - ${icon}"
      "L+ '${cfg.customDir}/public/assets/img/favicon.png' - - - - ${icon}"
      "L+ '${cfg.customDir}/public/assets/img/favicon.svg' - - - - ${icon}"
      "L+ '${cfg.customDir}/public/assets/img/apple-touch-icon.png' - - - - ${icon}"
      "L+ '${cfg.customDir}/public/assets/css/theme-custom.css' - - - - ${css}"
    ];

  # age.secrets.forgejo-mailer-password = {
  #   file = ../secrets/forgejo-mailer-password.age;
  #   mode = "400";
  #   owner = "forgejo";
  # };
}
