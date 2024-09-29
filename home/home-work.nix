{ pkgs, ... }:

let
  commonPackages = import ./home-common-packages.nix { pkgs = pkgs; };
  runShApp = appName: "nohup ${appName} >/dev/null 2>&1 &";

in {
  programs = {
    git.userEmail = "dmitrii.skurikhin@anna.money";
    zsh = {
      shellAliases = {
        stashenv =
          "git add -N . && git update-index --assume-unchanged flake.nix flake.lock pyproject.toml poetry.lock .envrc";
        unstashenv =
          "git update-index --no-assume-unchanged flake.nix flake.lock pyproject.toml poetry.lock .envrc && gaa && gst";
        shwebstorm = runShApp "webstorm";
        shpycharm = runShApp "pycharm-community";
        shrider = runShApp "rider";
      };
    };
  };

  home = {
    homeDirectory = "/home/work";
    username = "work";
  };

  home.packages = with pkgs;
    [
      docker-client
      slack
      jetbrains.webstorm
      jetbrains.rider
      jetbrains.pycharm-community
    ] ++ commonPackages;
}
