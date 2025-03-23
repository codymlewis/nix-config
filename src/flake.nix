{
    description = "A NixOS flake for configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        plasma-manager = {
            url = "github:nix-community/plasma-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.home-manager.follows = "home-manager";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, ... }: {
        # Home desktop
        nixosConfigurations.pt = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/pt.nix

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.cody = {
                        imports = [
                            inputs.plasma-manager.homeManagerModules.plasma-manager
                            ./home.nix
                        ];
                    };
                }
            ];
        };

        # Laptop
        nixosConfigurations.it = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/it.nix

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.cody = {
                        imports = [
                            inputs.plasma-manager.homeManagerModules.plasma-manager
                            ./home.nix
                        ];
                    };
                }
            ];
        };

        # University desktops
        nixosConfigurations.sees = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/sees.nix

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.cody = import ./home.nix;
                }
            ];
        };
    };
}
