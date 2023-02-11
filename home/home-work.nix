{ pkgs, ... }:

let commonPackages = import ./home-common-packages.nix { pkgs = pkgs; };

in {
  programs = { git.userEmail = "dmitrii.skurikhin@anna.money"; };

  home = {
    homeDirectory = "/home/work";
    username = "work";
  };

  home.packages = with pkgs; [ docker-client slack ] ++ commonPackages;
}
