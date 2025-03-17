{ lib, pkgs, ... }:


{
    imports = [
        ./common.nix
    ];

    boot.kernelModules = [
        "i2c-dev"
        "amdgpu"
    ];
    hardware.i2c.enable = true;

    # Ensure amd drivers are setup
    systemd.tmpfiles.rules = let
        rocmEnv = pkgs.symlinkJoin {
            name = "rocm-combined";
            paths = with pkgs.rocmPackages; [
                rocblas
                hipblas
                clr
            ];
    };
    in [
        "L+    /opt/rocm/hip   -    -    -     -    ${rocmEnv}"
    ];
    hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
    ];
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    networking.hostName = "pt";
    hardware.bluetooth.enable = true;

    environment.systemPackages = with pkgs; [
        nvtopPackages.amd
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

    system.autoUpgrade.flake = "/etc/nixos#pt";
}
