# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
    imports = [
        ../hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.memtest86.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking = {
    	nameservers = [ "1.1.1.1" "9.9.9.9" ];
        dhcpcd.extraConfig = "nohook resolve.conf";

        networkmanager = {
            enable = true;
            dns = "systemd-resolved";
        };
    };
    systemd.network.wait-online.enable = false;

    services.resolved = {
        enable = true;
        dnssec = "false";
        domains = [ "~." ];
        fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
        dnsovertls = "opportunistic";
    };

    time.timeZone = "Australia/Sydney";
    i18n.defaultLocale = "en_AU.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
    };

    services.desktopManager.plasma6.enable = true;
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
                user = "cody";
            };
        };
    };

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    users.users.cody = {
        isNormalUser = true;
        description = "Cody";
        extraGroups = [ "networkmanager" "wheel" "video" "gamemode" ];
    };

    environment.systemPackages = with pkgs; [
        git
        wget
        htop
        libreoffice-qt
        hunspell
        hunspellDicts.en_AU
    ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    services.flatpak.enable = true;
    programs.gnupg.agent.enable = true;

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
    ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    system.autoUpgrade = {
        enable = true;
        flags = [
            "--recreate-lock-file"
            "--update-input"
            "nixpkgs"
            "-L"
        ];
        dates = "02:00";
        randomizedDelaySec = "15min";
    };

    system.stateVersion = "24.11";
}
