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
                  options = subvol: [
                    "subvol=${subvol}"
                    "compress-force=zstd"
                    "noatime"
                  ];
                in {
                  "/" = { # will be wiped on every boot
                    mountpoint = "/";
                    mountOptions = options "root"
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = options "nix"
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = options "persist"
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
  };

  fileSystems = {
    "/nix".neededForBoot = true;
    "/persist".neededForBoot = true;
  };
}
