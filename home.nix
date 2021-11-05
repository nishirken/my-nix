{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      userName = "Dmitrii Skurikhin";
      userEmail = "dmitrii.sk@gmail.com";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        sudocode = "sudo code --user-data-dir '\.' --no-sandbox";
        homenix = "code ~/.config/nixpkgs/home.nix";
        logout = "gnome-session-save --force-logout";
      };
      localVariables = {
        NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "lambda";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        window = {
          gtk_theme_variant = "Orchis";
          startup_mode = "Fullscreen";
        };
        # colors = {
        #   primary = {
        #     background = "#2e3440";
        #     foreground = "#eceff4";
        #   };
        #   selection = {
        #     background = "#434c5e";
        #   };
        #   cursor = {
        #     cursor = "#d8dee9";
        #   };
        # };
        cursor = {
          style = "Beam";
          blinking = "On";
        };
      };
    };
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [ 
        bbenoist.Nix
        haskell.haskell
        ms-vscode.cpptools
      ];
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    keyboard = {
      layout = "us,ru";
      options = [ "grp:super_space_toggle" ];
    };
    username = "nish";
    homeDirectory = "/home/nish";
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
    tor
    tor-browser-bundle-bin
    thunderbird
    xdotool
    deluge
    vlc
    spotify
    tdesktop
    nheko
    bind
    drawio
    run-scaled
    gnome.gnome-tweaks
    hid-listen
    unetbootin
  ];

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
