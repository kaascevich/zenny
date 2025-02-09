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
              mountOptions = [ "defaults" "fmask=0137" "dmask=0027" ];
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
                extraArgs = [ "-L" "main" "-f" ];
                subvolumes = let
                  subvolume = name: mountpoint: {
                    inherit mountpoint;
                    mountOptions = [
                      "subvol=${name}"
                      "compress-force=zstd"
                      "noatime"
                    ];
                  };
                in {
                  "/rootfs"  = subvolume "rootfs"  "/";
                  "/nix"     = subvolume "nix"     "/nix";
                  "/config"  = subvolume "config"  "/config";
                  "/persist" = subvolume "persist" "/persist";
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = 16 * 1024;
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/nix".neededForBoot = true;
    "/persist".neededForBoot = true;
    "/config".neededForBoot = true;
  };
}
