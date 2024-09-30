{ lib, pkgs, ... }:

let
  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode direct --color 000000
    done
  '';
in
{
    imports = [
        ./common.nix
    ];

    services.udev.packages = [ pkgs.openrgb ];
    boot.kernelModules = [
        "i2c-dev"
        "amdgpu"
    ];
    hardware.i2c.enable = true;

    systemd.services.no-rgb = {
        description = "no-rgb";
        serviceConfig = {
            ExecStart = "${no-rgb}/bin/no-rgb";
            Type = "oneshot";
        };
        wantedBy = [ "multi-user.target" ];
    };

    # Ensure amd drivers are setup
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
    programs.gamemode = {
        enable = true;
        settings = {
            general = {
                renice = 10;
            };

            gpu = {
                apply_gpu_optimisations = "accept-responsibility";
                gpu_device = 1;
                amd_performance_level = "high";
            };
        };
    };

    system.autoUpgrade.flake = "/etc/nixos#unit0";
}
