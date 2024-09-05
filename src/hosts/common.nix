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
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking = {
        nameservers = [ "1.1.1.1" "9.9.9.9" ];

        networkmanager = {
                enable = true;
                dns = "systemd-resolved";
        };
    };

    services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
        dnsovertls = "true";
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

    services.xserver.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = false;

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
        extraGroups = [ "networkmanager" "wheel" ];
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
        noto-fonts-cjk
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

    system.stateVersion = "24.05";

}