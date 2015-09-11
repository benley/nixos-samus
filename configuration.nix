# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./pixel.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/disk/by-id/ata-HTS721010G9SA00_MPDZN7Y0J4W9ZL";
  #boot.loader.grub.enableCryptodisk = true;

  networking.hostName = "pixel";
  #networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  time.timeZone = "US/Pacific";

  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # services.openssh.enable = true;
  # services.printing.enable = true;

  hardware.enableAllFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  #hardware.opengl.s3tcSupport = true;

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
    displayManager.desktopManagerHandlesLidAndPower = false;

    #windowManager.i3.enable = true;

    wacom.enable = true;
  };

  services.xserver.synaptics = {
    enable = true;
    buttonsMap = [ 1 2 3 ];
    fingersMap = [ 1 2 3 ];
    palmDetect = true;
    tapButtons = true;
    twoFingerScroll = true;
    vertEdgeScroll = false;
    horizontalScroll = true;
  };

  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  #services.redshift = {
  #  enable = true;
  #  latitude = "37.7749300";
  #  longitude = "-122.4194200";
  #  temperature.day = 6500;
  #  temperature.night = 3500;
  #};

  services.avahi.enable = true;
  services.avahi.ipv4 = true;
  services.avahi.ipv6 = true;
  services.avahi.nssmdns = true;

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

}
