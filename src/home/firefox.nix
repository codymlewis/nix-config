{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
            extraPolicies = {
                DisableTelemetry = true;
                DNSOverHTTPS = {
                    Enabled = true;
                    Fallback = false;
                };
                EnableTrackingProtection = true;
                HttpsOnlyMode = "force_enabled";
                PasswordManagerEnabled = false;
                PictureInPicture = {
                    Enabled = false;
                    Locked = true;
                };
                PostQuantumKeyAgreementEnabled = true;
                DisablePocket = true;
                DisableFirefoxAccounts = true;
                SearchSuggestEnabled = false;
                DisplayBookmarksToolbar = "never";
                DisplayMenuBar = "default_off";

                ExtensionSettings = {
                    "*".installation_mode = "blocked";
                    "addon@darkreader.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                    "keepassxc-browser@keepassxc.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "uBlock0@raymondhill.net" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                    "sponsorBlocker@ajay.app" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "zotero@chnm.gmu.edu" = {
                        install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.144";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                };

                Preferences = {
                    "widget.use-xdg-desktop-portal.file-picker" = { Value = 1; Status = "locked"; };
                    "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
                    "extensions.pocket.enabled" = { Value = false; Status = "locked"; };
                    "extensions.screenshots.disabled" = { Value = true; Status = "locked"; };
                    "browser.newtabpage.activity-stream.showSponsored" = { Value = false; Status = "locked"; };
                    "browser.newtabpage.activity-stream.system.showSponsored" = { Value = false; Status = "locked"; };
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = { Value = false; Status = "locked"; };
                    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = { Value = false; Status = "locked"; };
                  };
            };
        };
        profiles.default.settings = {
            "browser.startup.homepage" = "about:home";
            "browser.newtabpage.activity-stream.topSitesRows" = 2;
            "browser.newtabpage.pinned" = [
                {
                    label = "proton";
                    url = "https://www.proton.me";
                }
                {
                    label = "github";
                    url = "https://www.github.com";
                }
                {
                    label = "standard notes";
                    url = "https://app.standardnotes.com";
                }
                {
                    label = "UoN Email";
                    url = "https://outlook.office.com/mail/";
                }
                {
                    label = "overleaf";
                    url = "https://www.overleaf.com";
                }
                {
                    label = "canvas";
                    url = "https://canvas.newcastle.edu.au";
                }
                {
                    label = "youtube";
                    url = "https://www.youtube.com";
                }
                {
                    label = "twitch";
                    url = "https://twitch.tv";
                }
                {
                    label = "steam";
                    url = "https://store.steampowered.com";
                }
                {
                    label = "one piece";
                    url = "https://mangaplus.shueisha.co.jp/titles/100020";
                }
            ];
        };
        profiles.default.search = {
            force = true;
            default = "StartPage";
            privateDefault = "StartPage";
            engines = {
                "StartPage" = {
                    urls = [{ template = "https://www.startpage.com/sp/search?q={searchTerms}"; }];
                    definedAliases = [ "@sp" ];
                };

                "Nix Packages" = {
                    urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
                    definedAliases = [ "nixp" ];
                };

                "Nix Options" = {
                    urls = [{ template = "https://search.nixos.org/options?query={searchTerms}"; }];
                    definedAliases = [ "nixo" ];
                };
            };
        };
    };
}
