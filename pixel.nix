{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_4_2;

  boot.initrd.kernelModules = [
    "intel_agp"
    "i915"  # necessary for console output early in the boot process
  ];

  # From https://github.com/raphael/linux-samus
  boot.extraModprobeConfig = ''
    options snd slots=snd_soc_sst_bdw_rt5677_mach,snd-hda-intel
  '';

  nixpkgs.config = {
    packageOverrides = pkgs: {

      linux_4_2 = pkgs.linux_4_2_samus;  # Custom kernel

      bluez = pkgs.bluez5;

    };
  };

  hardware.cpu.intel.updateMicrocode = true;
  nixpkgs.config.allowUnfree = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  hardware.enableAllFirmware = true;

  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.s3tcSupport = true;
}
