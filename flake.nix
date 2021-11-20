{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.home-manager.url = "github:nix-community/home-manager/release-21.11";

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ({ ... }: {
          nix.registry.nixpkgs.flake = nixpkgs;
        })
      ];
    };

    homeConfigurations.nish = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      homeDirectory = "/home/nish";
      username = "nish";
      stateVersion = "21.11";
      configuration.imports = [ ./home.nix ];
    };
  };
}
