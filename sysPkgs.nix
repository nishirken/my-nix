  {pkgs, ...}:

  {
    environment.systemPackages = with pkgs; [
      xorg.xbacklight
      parted
      pciutils
      lshw
      home-manager
    ];
    programs.steam.enable = true;
    programs.light.enable = true;
  }
