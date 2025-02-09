{ config, lib, pkgs, ... }: {
  boot.initrd.systemd.services.rollback = {
    description = "Rollback root subvolume to a pristine state";
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@enc.service" ]; # LUKS/TPM
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = builtins.readFile ../../scripts/rollback.sh;
  };
}
