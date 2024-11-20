{ ... }:

{
    imports = [
        ./common.nix
    ];

    networking.hostName = "it";

    hardware.bluetooth.enable = true;

    system.autoUpgrade.flake = "/etc/nixos#it";

}
