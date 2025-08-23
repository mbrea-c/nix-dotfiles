{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    policies = {
      DisablePocket = true;
      Preferences = let
        locked = value: {
          Value = value;
          Status = "locked";
        };
      in {
        "widget.use-xdg-desktop-portal.file-picker" = locked 1;
        "browser.aboutConfig.showWarning" = locked false;
        "browser.compactmode.show" = locked true;
        "browser.fullscreen.autohide" = locked false;
        # "dom.webgpu.enabled" = locked true;
        "extensions.autoDisableScopes" = locked 0;
      };
      FirefoxHome = {
        "TopSites" = false;
        "SponsoredTopSites" = false;
        "Stories" = false;
        "SponsoredStories" = false;
      };
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = { };

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          return-youtube-dislikes
          zotero-connector
          tree-style-tab
        ];
      };

      search = {
        force = true;
        default = "ddg";
        order = [ "ddg" "google" ];

        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          home-manager-options = {
            name = "Home Manager Options";
            urls = [{
              template =
                "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
              params = [{
                name = "query";
                value = "{searchTerms}";
              }];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@hmo" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{
              template =
                "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            }];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nw" ];
          };

          bing.metaData.hidden = true;

          google.metaData.alias =
            "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };
  };
}
