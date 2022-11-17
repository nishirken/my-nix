{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub = {
      configurationLimit = 10;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

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
     extraGroups = [ "wheel" "input" "podman" ];
    };
  };

  systemd.user.services.graphical = {
    script = ''
      set QT_AUTO_SCREEN_SCALE_FACTOR=true
    '';
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  nixpkgs.config.allowUnfree = true;

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
    trustedUsers = [ "root" "nish" ];
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://nishirken.cachix.org"
        "https://cache.nixos.org"
        "https://hydra.iohk.io"
        "https://nixcache.reflex-frp.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nishirken.cachix.org-1:AcLJoEJYmCuyAjs5GmzmZDM4EuT2DAGH3mFIC3KvkYM="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      ];
    };
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

  time.hardwareClockInLocalTime = true;
  system.stateVersion = "22.05";

  networking.networkmanager.enable = true;

  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.dnsname.enable = true;
    };
  };
}

