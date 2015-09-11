{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_4_2;

  boot.initrd.kernelModules = [
    "intel_agp"
    "i915"  # necessary for console output early in the boot process
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: {

      linux_4_2 = pkgs.linux_4_2_samus;  # Custom kernel

      bluez = pkgs.bluez5;

    };
  };

  hardware.cpu.intel.updateMicrocode = true;
  nixpkgs.config.allowUnfree = true;

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  powerManagement.cpuFreqGovernor = "powersave";
}
