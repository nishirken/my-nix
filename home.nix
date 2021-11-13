args@{ config, pkgs, ... }:

let
  myTor = pkgs.callPackage ./tor.nix args;
  in
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
        confnix = "code ~/Projects/my-nix/configuration.nix";
        sysnix = "code ~/Projects/my-nix/sysPkgs.nix";
        homenix = "code ~/Projects/my-nix/home.nix";
        logout = "gnome-session-save --force-logout";
        pnow = "gaa 'gcn! --no-verify' gpf";
        grb = "git rebase -i origin/master";
        grc = "git rebase --continue";
        grba = "git rebase -i --autosquash origin/master";
        go = "git checkout ";
        gs = "git status ";
        gl = "git log ";
        glf = "git log --stat --pretty=short --graph";
        gd = "git diff ";
        gst = "git stash ";
        gm = "git merge ";
        gc = "git commit ";
        ga = "git add";
        gf = "git fetch ";
        gpl = "git pull ";
        gps = "git push";
        gr = "git reset ";
        grhard = "git reset --hard ";
        gpf = "git push --force";
        gb = "git branch ";
        got = "git checkout --theirs";
        goo = "git checkout --ours";
      };
      localVariables = {
        NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "npm"
          "yarn"
          "node"
          "stack"
          "cabal"
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
    myTor
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
