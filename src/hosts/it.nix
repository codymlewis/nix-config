{ lib, pkgs, ... }:

{
    imports = [
        ./common.nix
    ];

    networking.hostName = "it";
    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [
        nvtopPackages.intel
        lutris
        wineWowPackages.waylandFull
        winetricks
        mangohud
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
    ];
    programs.steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];
    };



    system.autoUpgrade.flake = "/etc/nixos#it";

}
