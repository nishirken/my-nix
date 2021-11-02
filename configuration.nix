{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./sysPkgs.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kbd-backlit" ];
  boot.extraModulePackages = [
    (pkgs.callPackage (import /home/nish/Projects/kbd-backlit) {
      pkgs = pkgs;
    })
  ];

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      videoDrivers = [ "modesetting" ];
      useGlamor = true;
      layout = "us,ru";
      xkbOptions = "grp:super_space_toggle";
      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          clickMethod = "clickfinger";
        };
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.nish = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware = {
    pulseaudio.enable = true;
    enableAllFirmware = true;
  };

  nix = {
    gc.automatic = true;
    optimise.automatic = true;
  };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      powerline-fonts
      noto-fonts-emoji
    ];
  };

  environment.variables = {
    BROWSER = "firefox";
    EDITOR = "code";
  };
  environment.pathsToLink = [ "/share/zsh" ];
  system.stateVersion = "21.05";
  time.hardwareClockInLocalTime = true;
}

