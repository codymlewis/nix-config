{ ... }:

{
	imports = [
                ./common.nix
        ];

        networking.hostName = "unit1";

        hardware.bluetooth.enable = true;

        services.displayManager.autoLogin.enable = true;
        services.displayManager.autoLogin.user = "cody";

        system.autoUpgrade.flake = "/etc/nixos#unit1";

}
