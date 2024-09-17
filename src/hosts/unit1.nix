{ ... }:

{
	imports = [
                ./common.nix
        ];

        networking.hostName = "unit1";

        hardware.bluetooth.enable = true;

        system.autoUpgrade.flake = "/etc/nixos#unit1";

}
