{ inputs, pkgs, ... }: {
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
        "dom.webgpu.enabled" = locked true;
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

      search = {
        force = true;
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" "Google" ];

        extensions = {
          packages = with inputs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            return-youtube-dislikes
            zotero-connector
            tree-style-tab
          ];
        };

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
