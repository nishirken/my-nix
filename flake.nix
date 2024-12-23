{
  nixConfig = {
    extra-substituters = ''
      https://nix-community.cachix.org
      https://nishirken.cachix.org
    '';
    extra-trusted-public-keys = ''
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      nishirken.cachix.org-1:AcLJoEJYmCuyAjs5GmzmZDM4EuT2DAGH3mFIC3KvkYM=
    '';
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    awesome-neovim-plugins.url = "github:m15a/flake-awesome-neovim-plugins";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs = { self, nixpkgs, home-manager, awesome-neovim-plugins, alacritty-theme, ... }:
    let
      modules = [
        ./home/home-common.nix
        ./home/vim.nix
        ./home/code.nix
        ./home/zsh.nix
        ./home/terminal.nix
      ];
      commonPkgsArgs = {
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [
          awesome-neovim-plugins.overlays.default
          alacritty-theme.overlays.default
      ];
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./environment.nix

          home-manager.nixosModules.home-manager

          ({ pkgs, ... }: {
            nix.extraOptions = "experimental-features = nix-command flakes";
            nix.registry.nixpkgs.flake = nixpkgs;
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;

            environment.systemPackages =
              [ (import home-manager { pkgs = pkgs; }).home-manager ];
          })
        ];
      };

      homeConfigurations.nish = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = modules ++ [ ./home/home-nish.nix ];
      };

      homeConfigurations.work = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = modules ++ [ ./home/home-work.nix ];
      };
    };
}
