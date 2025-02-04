{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/some-disk-id"; # will be overwritten
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
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=2G" "mode=755" ];
      };
      "/home/kaleb" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=4G" "mode=777" ];
      };
    };
  };

  fileSystems = {
    "/nix".neededForBoot = true;
    "/persist".neededForBoot = true;
  };
}
