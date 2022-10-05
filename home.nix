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
      userEmail = "dmitrii.sk@gmail.com";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      "tap-to-click" = true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    keyboard = {
      layout = "us,ru";
      options = [ "grp:super_space_toggle" ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis";
      package = pkgs.orchis;
    };
    iconTheme = {
      name = "Tela";
      package= pkgs.tela-icon-theme;
    };
  };

  home.packages = with pkgs; [
    mailspring
    xdotool
    deluge
    vlc
    spotify
    tdesktop
    bind
    run-scaled
    ms-sys
    (makeAutostartItem { name = "libinput-gestures"; package = libinput-gestures; })
    nodejs
    openvpn
    libreoffice
    fzf
    silver-searcher
    bat
    skypeforlinux
    templates
    hcw
    hcli
    docker-client
    audacious
    zoom-us
    chromium
    gimp
    libheif # for jpg
    jpegoptim # for jpg
    optipng # for png
    imagemagick
    jetbrains.idea-community
    jq
    morgen # calendar
    postman
    dbeaver
    openssh
    cachix
  ];

  nixpkgs.config.allowUnfree = true;
}
