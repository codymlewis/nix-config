{ lib, pkgs, ... }:

{
    imports = [
        ./common.nix
    ];

    # Ensure amd drivers are setup
    boot.initrd.kernelModules = [ "amdgpu" ];
    systemd.tmpfiles.rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    hardware.opengl.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];
    hardware.opengl.driSupport = true; # This is already enabled by default
    hardware.opengl.driSupport32Bit = true; # For 32 bit applications

    networking.hostName = "unit0";

    hardware.bluetooth.enable = true;

    services.hardware.openrgb.enable = true;

    environment.systemPackages = with pkgs; [
        nvtopPackages.amd
        lutris
        wineWowPackages.waylandFull
        winetricks
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
    ];
    hardware.steam-hardware.enable = true;

    system.autoUpgrade.flake = "/etc/nixos#unit0";

}
