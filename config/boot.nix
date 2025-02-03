{ config, lib, pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" "wl" ];
    extraModulePackages = [ ];

    loader.efi.canTouchEfiVariables = true;

    # Lanzaboote currently replaces the systemd-boot module. This setting is
    # set to true by default, so we force it to false for now.
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    # for hibernation
    # kernelParams = [ "resume_offset=533760" ];
    # resumeDevice = "/dev/disk/by-label/root";
  };
}
