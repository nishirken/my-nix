{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub = { configurationLimit = 10; };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = { openvpn3.enable = true; };

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      displayManager = { gdm.enable = true; };
      desktopManager.gnome.enable = true;
      videoDrivers = [ "modesetting" ];
      xkb.layout = "us,ru";
      xkb.options = "grp:super_space_toggle";
    };
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };
    accounts-daemon.enable = true;
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "conservative";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.nish = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" ];
      hashedPassword =
        "$y$j9T$qdvZ0ynmV14YU5TqvTLUO.$PW6h7tKJXxWA3tDAwh1QMhRj.FKMAgzrPPDbOfxGRU3";
    };
    users.work = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" ];
      hashedPassword =
        "$y$j9T$OkFUzghXyf9JOh1vdAnuW0$PioS30uNtvmlu7E/T4ewgaLhPlid0DgsIZLe/Pc9j/1";
    };
  };

  systemd.user.services.graphical = {
    script = ''
      set QT_AUTO_SCREEN_SCALE_FACTOR=true
    '';
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  nixpkgs.config = { allowUnfree = true; };
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      trusted-users = [ "root" "nish" "work" ];
      substituters = [ "https://cache.nixos.org" ];
      accept-flake-config = true;
    };
  };

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [ corefonts powerline-fonts noto-fonts-emoji ];
  };

  time.hardwareClockInLocalTime = true;
  system.stateVersion = "24.11";

  networking.networkmanager.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}

