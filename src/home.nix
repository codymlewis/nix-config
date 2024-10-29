{ pkgs, ... }:

{
    home.username = "cody";
    home.homeDirectory = "/home/cody";

    home.packages = [
        pkgs.strawberry
        pkgs.wl-clipboard
        pkgs.krita
        pkgs.nil
    ];

    imports = [
        ./home/firefox.nix
        ./home/fish.nix
        ./home/git.nix
        ./home/mpv.nix
        ./home/neovim.nix
    ];

    home.stateVersion = "24.05";
}
