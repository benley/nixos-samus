{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableGoogleTalkPlugin = true;
    firefox.enableGnomeExtensions = true;
    # firefox.enableAdobeFlash = true;
    # chromium.enablePepperFlash = true;
    # chromium.enablePepperPDF = true;
    # chromium.enableWideVine = true;
  };

  environment.systemPackages = with pkgs; [
    acpi
    chromiumDev
    curl
    dmidecode
    firefoxWrapper
    git
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    pciutils
    usbutils
    vagrant
    wget
    xlibs.xdpyinfo
    xlibs.xlsfonts
  ];

  fonts = {
    # Broken? Also perhaps unnecessary.
    # fontconfig.dpi = 180;

    fonts = with pkgs; [
      anonymousPro
      aurulent-sans
      bakoma_ttf
      cantarell_fonts
      crimson
      corefonts
      dejavu_fonts
      dina-font
      dosemu_fonts
      fantasque-sans-mono
      fira
      fira-code
      fira-mono
      freefont_ttf
      hasklig
      inconsolata
      liberation_ttf
      meslo-lg
      powerline-fonts
      proggyfonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      tewi-font
      ttf_bitstream_vera
      ubuntu_font_family
      unifont
      vistafonts
    ];
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay";
  };

  # Virtualbox
  nixpkgs.config.virtualbox.enableExtensionPack = true;
  services.virtualbox.host.enable = true;

}
