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
                    # See about:support for addon ids
                    "addon@darkreader.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "navbar";
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
                    "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "vpn@proton.ch" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "ezproxyredirectfoxified@foo.bar" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ezproxy-redirect-foxified/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "{a9c2ad37-e940-4892-8dce-cd73c6cbbc0c}" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/feedbroreader/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                };

                Preferences = {
                    "media.hardware-video-decoding.force-enabled" = { Value = true; Status = "locked"; };
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
            default = "DuckDuckGo";
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
