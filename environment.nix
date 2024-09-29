{ pkgs, config, ... }:

{
  environment = with pkgs; {
    variables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
    gnome.excludePackages = [ xterm ];
    shells = [ zsh ];

    systemPackages = [ xorg.xbacklight parted pciutils lshw xclip docker-compose docker-client ];
  };

  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs:
        with config.hardware.opengl;
        if pkgs.hostPlatform.is64bit then
          [ package pkgs.ncurses ] ++ extraPackages
        else
          [ package32 ] ++ extraPackages32;
    };
  };
  programs.light.enable = true;
  services.blueman.enable = true;
}
