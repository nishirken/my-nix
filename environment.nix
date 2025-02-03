{ pkgs, config, ... }:

{
  environment = with pkgs; {
    variables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };
    gnome.excludePackages = [ xterm ];
    shells = [ zsh ];

    systemPackages = [ xorg.xbacklight parted pciutils lshw xclip docker-compose docker-client xdg-utils ];
  };

  programs = {
    openvpn3.enable = true;
    zsh.enable = true;
    light.enable = true;
  };

  services.blueman.enable = true;
}
