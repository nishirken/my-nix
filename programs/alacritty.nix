{ pkgs, ... }:

{
    programs.alacritty = {
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
}