  { pkgs, ... }:

  {
    environment.systemPackages = with pkgs; [
      xorg.xbacklight
      parted
      pciutils
      lshw
      xclip
    ];
    programs.steam.enable = true;
    programs.light.enable = true;
  }
