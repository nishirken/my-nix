{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # ({ pkgs, ... }: {
        #   boot.loader = {
        #     systemd-boot.enable = true;
        #     efi.canTouchEfiVariables = true;
        #   };
        # })
        ./configuration.nix
      ];
    };
  };
}
