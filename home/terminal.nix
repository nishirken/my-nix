{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations_theme_variant = "Dark";
        startup_mode = "Fullscreen";
      };
      env = { TERM = "xterm-256color"; };
      # Colors (Nord)
      colors = {
        primary = {
          background = "#2E3440";
          foreground = "#D8DEE9";
        };
        normal = {
          black = "#3B4252";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#81A1C1";
          magenta = "#B48EAD";
          cyan = "#88C0D0";
          white = "#E5E9F0";
        };
        bright = {
          black = "#4C566A";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#81A1C1";
          magenta = "#B48EAD";
          cyan = "#8FBCBB";
          white = "#ECEFF4";
        };
        cursor = { cursor = "#d08770"; };
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
    };
  };
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
    '';
  };
}
