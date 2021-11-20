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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        autoLogin.user = "nish";
        autoLogin.enable = true;
      };
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
    accounts-daemon.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.nish = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "video" "audio" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  hardware = {
    pulseaudio.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
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
  environment.shells = with pkgs; [ bashInteractive zsh ];
  time.hardwareClockInLocalTime = true;
  system.stateVersion = "21.05";
}

