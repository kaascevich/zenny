{
  disko.devices = {
    disk.internal = {
      type = "disk";
      device = "/dev/nvme1n1";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "4G";
            label = "boot";
            name = "esp";
            type = "ef00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          primary = {
            size = "100%";
            label = "primary";
            content = {
              type = "luks";
              name = "crypt";
              extraOpenArgs = [
                "--allow-discards"
                "--perf-no_read_workqueue"
                "--perf-no_write_workqueue"
              ];
              settings.crypttabExtraOpts = [
                "tmp2-device=auto"
                "tpm2-measure-pcr=yes"
              ];
              content = {
                type = "btrfs";
                extraArgs = [ "-L" "root" "-f" ];
                subvolumes = let
                  compress = "compress-force=zstd";
                  noatime = "noatime";
                in {
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "subvol=nix" compress noatime ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "subvol=persist" compress noatime ];
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "16G";
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "size=2G" "mode=755" ];
    };
  };

  fileSystems = {
    "/nix".neededForBoot = true;
    "/persist".neededForBoot = true;
  };
}
