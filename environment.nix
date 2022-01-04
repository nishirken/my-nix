  { pkgs, ... }:

  {
    environment = with pkgs; {
      variables = {
        BROWSER = "firefox";
        EDITOR = "nvim";
      };
      gnome.excludePackages = [ xterm ];
      shells = [ zsh ];

      systemPackages = [
        xorg.xbacklight
        parted
        pciutils
        lshw
        xclip
      ];
  };

    programs.steam.enable = true;
    programs.light.enable = true;
  }
