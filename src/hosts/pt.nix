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
