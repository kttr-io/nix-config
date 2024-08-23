{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountOptions = [ "compress=zstd" ];
                      mountpoint = "/";
                    };
                    "@home" = {
                      mountOptions = [ "compress=zstd" ];
                      mountpoint = "/home";
                    };
                    "@nix" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/nix";
                    };
                    "@log" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/var/log";
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol";
                      swap = {
                        swapfile.size = "8G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
