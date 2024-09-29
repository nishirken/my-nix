{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ pkgs.alacritty-theme.gruvbox_material_medium_dark ];
      window = {
        decorations_theme_variant = "Dark";
        startup_mode = "Fullscreen";
      };
      env = { TERM = "xterm-256color"; };
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
