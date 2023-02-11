args@{ config, pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "Dmitrii Skurikhin";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = { "tap-to-click" = true; };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    keyboard = {
      layout = "us,ru";
      options = [ "grp:super_space_toggle" ];
    };
    stateVersion = "22.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis";
      package = pkgs.orchis;
    };
    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
