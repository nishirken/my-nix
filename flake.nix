{
  inputs.nixpkgs.url = "github:nishirken/nixpkgs/nixos-21.05-patched";
  inputs.nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager/release-21.05";

  outputs = { self, nixpkgs, nixpkgs_unstable, home-manager, ... }:

  let
    patched = (import nixpkgs { system = "x86_64-linux"; });
    unstable = (import nixpkgs_unstable { system = "x86_64-linux"; }); in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./environment.nix

	      home-manager.nixosModules.home-manager

        ({ pkgs, ... }: {
          nix.extraOptions = "experimental-features = nix-command flakes";
          nix.package = unstable.nix;
          nix.registry.nixpkgs.flake = nixpkgs;
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;

          environment.systemPackages = [
            (import home-manager { pkgs = unstable; }).home-manager
          ];
        })
      ];
    };

    homeConfigurations.nish = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      homeDirectory = "/home/nish";
      username = "nish";
      stateVersion = "21.05";
      pkgs = patched;
      configuration.imports = [
        ./home.nix
        ./emacs.nix
      ];
    };
  };
}
