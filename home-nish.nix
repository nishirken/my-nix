args@{ config, pkgs, ... }:

let commonPackages = import ./home-packages.nix { pkgs = pkgs; }; in

{
  programs = {
    git.userEmail = "dmitrii.sk@gmail.com";
  };

  home = {
    homeDirectory = "/home/nish";
    username = "nish";
  };

  home.packages = with pkgs; [
    mailspring
    deluge
    vlc
    libreoffice
    skypeforlinux
    templates
    hcw
    hcli
    morgen # calendar
    postman
    dbeaver
    cachix
    podman-compose
    gitkraken
    lutris
    wine64
    brave
  ] ++ commonPackages;
}
