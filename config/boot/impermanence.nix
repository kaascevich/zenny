{ config, lib, pkgs, ... }: {
  boot.initrd.systemd.services.rollback = {
    description = "Rollback root subvolume";
    wantedBy = [ "initrd.target" ];
    after = [ "initrd-root-device.target" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = builtins.readFile ../../scripts/rollback.sh;
  };
}
