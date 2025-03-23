{ pkgs, ... }:

{
    programs.konsole = {
        enable = true;
        defaultProfile = "default";

        profiles.default = {
            name = "default";
            command = "${pkgs.fish}/bin/fish";
            colorScheme = "Linux";
            font = {
                name = "Fira Code";
                size = 11;
	    };
            extraConfig = {
                General = {
                    ShowTerminalSizeHint = false;
                };

                KonsoleWindow = {
                    ShowMenuBarByDefault = false;
		};

                MainWindow = {
                    MenuBar = "Disabled";
                    ToolBarsMovable = "Disabled";
		};

                TabBar = {
                    TabBarVisibility = "ShowTabBarWhenNeeded";
		};
            };
        };
    };
}
