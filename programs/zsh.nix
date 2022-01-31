{ pkgs, ... }:

{
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        set QT_AUTO_SCREEN_SCALE_FACTOR=true
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
}
