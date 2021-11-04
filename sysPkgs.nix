  {pkgs, ...}:

  {
    environment.systemPackages = with pkgs; [
      xorg.xbacklight
      parted
      gparted
      touchegg
      gnomeExtensions.x11-gestures
      pciutils
      lshw
    ];
    programs.steam.enable = true;
    programs.light.enable = true;
    systemd.packages = [ pkgs.touchegg ];
    systemd.services.touchegg = {
      enable = true;
      description = "Touchégg. The daemon.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        Group = "input";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "${pkgs.touchegg}/bin/touchegg --daemon";
      };
    };
  }
