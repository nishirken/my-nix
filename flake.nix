{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    # nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    templates.url = "/home/nish/Projects/templates";
    hcw.url = "github:nishirken/hspec-cabal-watch/master";
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs_unstable,
    home-manager,
    templates,
    hcw,
    ... 
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./environment.nix

	home-manager.nixosModules.home-manager

        ({ pkgs, ... }: {
          nix.extraOptions = "experimental-features = nix-command flakes";
          nix.package = pkgs.nix_2_4;
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
      system = "x86_64-linux";
      homeDirectory = "/home/nish";
      username = "nish";
      stateVersion = "21.11";
      pkgs = (import nixpkgs {
        system = "x86_64-linux";
        overlays = [(final: _: {
          templates = templates.defaultPackage.${final.system};
          hcw = hcw.defaultPackage.${final.system};
        })];
      });
      configuration.imports = [
        ./home.nix
        ./programs/emacs.nix
        ./programs/vim.nix
        ./programs/code.nix
        ./programs/zsh.nix
        ./programs/terminal.nix
      ];
    };
  };
}
