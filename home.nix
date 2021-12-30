args@{ config, pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
    };
    git = {
      enable = true;
      userName = "Dmitrii Skurikhin";
      userEmail = "dmitrii.sk@gmail.com";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        eval "$(direnv hook zsh)"
      '';
      shellAliases = {
        sudocode = "sudo code --user-data-dir '\.' --no-sandbox";
        codenix = "code ~/Projects/my-nix";
        sys-switch = "sudo nixos-rebuild switch --flake ~/Projects/my-nix";
        home-switch = "home-manager switch --flake ~/Projects/my-nix";
        logout = "gnome-session-save --force-logout";
        cabalgen = "cabal2nix --shell";
        pbcopy = "xclip -selection clipboard";
        pbpaste = "xclip -selection clipboard -o";
        # git
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
    tor
    tor-browser-bundle-bin
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
    tmux
    nodejs
    openvpn
    libreoffice
  ];

  nixpkgs.config.allowUnfree = true;
}
