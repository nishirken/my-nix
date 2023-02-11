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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    # nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    templates.url = "github:nishirken/templates/master";
    hcw.url = "github:nishirken/hspec-cabal-watch/master";
    hcli.url = "github:nishirken/hcli/master";
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs_unstable,
    home-manager,
    templates,
    hcw,
    hcli,
    ... 
  }: let
      patchedZoom = pkgs: pkgs.zoom-us.overrideAttrs (attrs: {
         nativeBuildInputs = attrs.nativeBuildInputs or [] ++ [ pkgs.bbe ];
         postFixup = ''
           cp $out/opt/zoom/zoom .
           bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
         ''+ attrs.postFixup or "";
       });
      modules = [
        ./home-common.nix
        ./programs/vim.nix
        ./programs/code.nix
        ./programs/zsh.nix
        ./programs/terminal.nix
      ]; in {
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

          environment.systemPackages = [
            (import home-manager { pkgs = pkgs; }).home-manager
          ];
        })
      ];
    };

    homeConfigurations.nish = home-manager.lib.homeManagerConfiguration {
      pkgs = (import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ "electron-15.5.2" ];
        overlays = [(final: prev: {
          templates = templates.defaultPackage.${final.system};
          hcw = hcw.defaultPackage.${final.system};
          hcli = hcli.defaultPackage.${final.system};
          zoom-us = patchedZoom prev;
        })];
      });
      modules = modules ++ [./home-nish.nix];
    };

    homeConfigurations.work = home-manager.lib.homeManagerConfiguration {
      pkgs = (import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.permittedInsecurePackages = [ "electron-15.5.2" ];
        overlays = [(final: prev: {
          zoom-us = patchedZoom prev;
        })];
      });
      modules = modules ++ [./home-work.nix];
    };
  };
}
