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
  boot.kernelModules = [ "dell_laptop" ];
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.gz";
        sha256 = "4d7908da75ad50a70a0141721e259c2589b7bdcc317f7bd885b80c2ffa689211";
      };
      version = "5.15";
      modDirVersion = "5.15.0";
      ignoreConfigErrors = true;
    };
  });

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
     extraGroups = [ "wheel" "input" "video" "audio" ];
  };
  users.extraGroups.vboxusers.members = [ "nish" ];

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
  system.stateVersion = "21.05";
  time.hardwareClockInLocalTime = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;  
}

