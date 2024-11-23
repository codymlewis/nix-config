{ ... }:

{
    imports = [
        ./common.nix
    ];

    networking.hostName = "it";

    hardware.bluetooth.enable = true;

    services.openssh = {
        enable = false;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = false;
            AllowUsers = [ "cody" ];
            UseDns = false;
            X11Forwarding = false;
            PermitRootLogin = "no";
        };
    };

    networking.firewall.allowedTCPPorts = [ 22 ];

    system.autoUpgrade.flake = "/etc/nixos#it";

}
