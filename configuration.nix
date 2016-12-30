# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

rec {
  imports = [
    ./hardware-configuration.nix
    ./pixel.nix
    ./apps.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/disk/by-id/ata-HTS721010G9SA00_MPDZN7Y0J4W9ZL";
  #boot.loader.grub.enableCryptodisk = true;

  networking = {
    hostName = "pixel";
    hostId = "a8c08f02";

    # One of these, not both:
    networkmanager.enable = true;
    wireless.enable = !networking.networkmanager.enable;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "US/Pacific";

  environment.systemPackages = with pkgs; [ wget curl git ];

  # services.openssh.enable = true;
  # services.printing.enable = true;

  services.xserver = {
    enable = true;
    exportConfiguration = true;
    layout = "us";
    # xkbOptions = "eurosign:e";
    useGlamor = true;
    #videoDrivers = [ "intel" ];
    vaapiDrivers = [ pkgs.vaapiIntel ];

    desktopManager.gnome3.enable = true;

    displayManager.slim.enable = true;
    displayManager.desktopManagerHandlesLidAndPower = true;

    wacom.enable = true;
  };

  services.xserver.synaptics = {
    enable = true;
    buttonsMap = [ 1 3 2 ];  # Not a typo, and
    fingersMap = [ 1 2 3 ];  # yes it is weird.
    palmDetect = true;
    tapButtons = true;
    twoFingerScroll = true;
    vertEdgeScroll = false;
    horizontalScroll = true;
    minSpeed = "1.5";
    maxSpeed = "2.0";
    accelFactor = "0.3";
  };

  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  services.redshift = {
    enable = true;
    latitude = "37.7749300";
    longitude = "-122.4194200";
    temperature.day = 6500;
    temperature.night = 3500;
  };

  services.avahi = {
    enable = true;
    ipv4 = true;
    ipv6 = true;
    nssmdns = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.benley = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
    description = "Benjamin Staffin";
  };

  programs.bash.enableCompletion = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  nix = {
    daemonIONiceLevel = 10;
    daemonNiceLevel = 10;
    extraOptions = ''
      auto-optimise-store = true
    '';
    buildCores = 4;
    # maxJobs = 4;  # defined in hardware-configuration.nix
    trustedBinaryCaches = [
      "https://hydra.nixos.org/"
    ];
    # distributedBuilds = true;
    # buildMachines = [
    #   { hostName = "ein.local";
    #     maxJobs = 4;
    #     sshKey = "/root/.ssh/id_ein_auto";
    #     sshUser = "nix";
    #     system = "x86_64-linux"; }
    #   { hostName = "nyanbox.local";
    #     maxJobs = 4;
    #     sshKey = "/root/.ssh/id_ein_auto";
    #     sshUser = "nix";
    #     system = "x86_64-linux"; }
    # ];
  };
}
