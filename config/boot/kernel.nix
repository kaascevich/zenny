{ config, lib, pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "wl" ];
    initrd.availableKernelModules = [
      "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"
    ];

    # enable the sysrq key (alt+prtsc on my laptop)
    kernel.sysctl."kernel.sysrq" = "502";

    loader.efi.canTouchEfiVariables = true;
  };
}
