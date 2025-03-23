{ ... }:

{
    programs.plasma = {
        enable = true;

        workspace = {
            lookAndFeel = "org.kde.breezedark.desktop";
        };

        fonts = {
            general = {
                family = "Noto Sans";
                pointSize = 11;
            };

            fixedWidth = {
                family = "Fira Code";
                pointSize = 11;
            };
        };

        hotkeys.commands = {
            "launch-konsole" = {
                name = "Launch Konsole";
                key = "Meta+Return";
                command = "konsole";
            };
            "launch-firefox" = {
                name = "Launch Firefox";
                key = "Meta+F";
                command = "firefox";
            };
        };

        panels = [
            {
                location = "top";
                widgets = [
                    {
                        kickoff = {
                            sortAlphabetically = true;
                            icon = "nix-snowflake-white";
                        };
                    }
                    {
                        iconTasks = {
                            launchers = [
                                "applications:org.kde.konsole.desktop"
                                "applications:org.kde.dolphin.desktop"
                            ];
                        };
                    }
                    "org.kde.plasma.marginsseparator"
                    "org.kde.plasma.pager"
                    {
                        systemTray.items = {
                            shown = [
                                "org.kde.plasma.volume"
                                "org.kde.plasma.bluetooth"
                                "org.kde.plasma.brightness"
                                "org.kde.plasma.networkmanagement"
                            ];
                            hidden = [
                                "org.kde.plasma.battery"
                                "org.kde.plasma.mediacontrol"
                                "org.kde.plasma.notifications"
                                "org.kde.plasma.clipboard"
                            ];
                        };
                    }
                    {
                        digitalClock = {
                            calendar.firstDayOfWeek = "sunday";
                            date.format = "isoDate";
                            time.format = "12h";
                        };
                    }
                ];
            }
        ];

        shortcuts = {
            "kwin"."Switch to Desktop 1" = ["Meta+1" "Meta+1,Meta+1,Switch to Desktop 1"];
            "kwin"."Switch to Desktop 2" = ["Meta+2" "Meta+2,Meta+2,Switch to Desktop 2"];
            "kwin"."Switch to Desktop 3" = ["Meta+3" "Meta+3,Meta+3,Switch to Desktop 3"];
            "kwin"."Switch to Desktop 4" = ["Meta+4" "Meta+4,Meta+4,Switch to Desktop 4"];
            "kwin"."Switch to Desktop 5" = ["Meta+5" "Meta+5,Meta+5,Switch to Desktop 5"];
            "kwin"."Window to Desktop 1" = ["Meta+!" "Meta+!,,Window to Desktop 0"];
            "kwin"."Window to Desktop 2" = ["Meta+@" "Meta+@,,Window to Desktop 2"];
            "kwin"."Window to Desktop 3" = ["Meta+#" "Meta+#,,Window to Desktop 3"];
            "kwin"."Window to Desktop 4" = ["Meta+$" "Meta+$,,Window to Desktop 4"];
            "kwin"."Window to Desktop 5" = ["Meta+%" "Meta+%,,Window to Desktop 5"];
        };

        configFile = {
            "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "820,584";
            "kdeglobals"."General"."AccentColor" = "146,110,228";
            "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
            "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
            "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
            "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
            "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
            "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
            "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
            "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
            "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
            "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
            "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
            "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
            "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
            "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
            "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
            "kdeglobals"."KFileDialog Settings"."Sort reversed" = true;
            "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 138;
            "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
            "kdeglobals"."WM"."activeBackground" = "49,54,59";
            "kdeglobals"."WM"."activeBlend" = "252,252,252";
            "kdeglobals"."WM"."activeForeground" = "252,252,252";
            "kdeglobals"."WM"."inactiveBackground" = "42,46,50";
            "kdeglobals"."WM"."inactiveBlend" = "161,169,177";
            "kdeglobals"."WM"."inactiveForeground" = "161,169,177";
            "kiorc"."Confirmations"."ConfirmDelete" = true;
            "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
            "kscreenlockerrc"."Daemon"."Autolock" = false;
            "kscreenlockerrc"."Daemon"."LockOnResume" = false;
            "kwalletrc"."Wallet"."First Use" = false;
            "kwinrc"."Desktops"."Id_1" = "fa81ad25-8954-4ae8-986c-4efd2c14a1bd";
            "kwinrc"."Desktops"."Id_2" = "7a11ce3f-4ce4-46c2-89d6-8fa40c053c9b";
            "kwinrc"."Desktops"."Id_3" = "e671f503-398a-4352-a2de-ce2b7ac6d256";
            "kwinrc"."Desktops"."Id_4" = "5f4a7350-f8cb-4d53-b95e-0ee9326507a2";
            "kwinrc"."Desktops"."Id_5" = "ec990ef2-bd18-4716-b535-80b2dddaaf84";
            "kwinrc"."Desktops"."Number" = 5;
            "kwinrc"."Desktops"."Rows" = 1;
            "kwinrc"."Effect-hidecursor"."InactivityDuration" = 5;
            "kwinrc"."Effect-overview"."BorderActivate" = 9;
            "kwinrc"."NightColor"."Active" = true;
            "kwinrc"."NightColor"."Mode" = "Location";
            "kwinrc"."Plugins"."hidecursorEnabled" = true;
            "kwinrc"."Tiling"."padding" = 4;
            "kwinrc"."Windows"."DelayFocusInterval" = 100;
            "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
            "kwinrc"."Windows"."Placement" = "Smart";
            "kwinrc"."Xwayland"."Scale" = 1.5;
            "kxkbrc"."Layout"."Options" = "ctrl:swapcaps";
            "kxkbrc"."Layout"."ResetOldOptions" = true;
            "plasma-localerc"."Formats"."LANG" = "en_AU.UTF-8";
            "plasmanotifyrc"."Applications/firefox"."Seen" = true;
            "spectaclerc"."GuiConfig"."captureMode" = 0;
            "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
            "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
        };

        dataFile = {
            "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
        };
    };
}
