{
    description = "A NixOS flake for configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        # Home desktop
        nixosConfigurations.pt = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/pt.nix

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.cody = import ./home.nix;
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
                    home-manager.users.cody = import ./home.nix;
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
