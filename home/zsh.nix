{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
    shellAliases = {
      sudocode = "sudo code --user-data-dir '.' --no-sandbox";
      vimnix = "nvim ~/Projects/my-nix";
      sys-switch = "sudo nixos-rebuild switch --flake ~/Projects/my-nix";
      home-switch =
        "NIXPKGS_ALLOW_INSECURE=1 home-manager switch --flake ~/Projects/my-nix --impure";
      logout = "gnome-session-save --force-logout";
      cabalgen = "cabal2nix --shell";
      cache = ''
        nix flake archive --json \
          | jq -r '.path,(.inputs|to_entries[].value.path)' \
          | cachix push nishirken
      '';
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
      gaapf = "gaa && gcn! && gpf";

      docker = "podman";
      nix-locate = "nix run github:nix-community/nix-index#nix-locate";

      vpnstart = "openvpn3 session-start --config ";
      vpnstop = "openvpn3 session-manage -D --config ";
      vpnkill = ''
        for session in $(openvpn3 sessions-list | grep -i 'path' | awk '{p=index($0, ":");print $2}'); do openvpn3 session-manage -D -o ''${session}; done'';
    };
    localVariables = {
      NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "npm" "yarn" "node" "stack" "cabal" ];
      theme = "lambda";
    };
  };
}
