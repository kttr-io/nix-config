{
  imports = [
    ../hybrid
  ];

  disko.devices.disk.main.content.partitions.root.content = {
    type = "btrfs";
    extraArgs = [ "-f" ]; # Override existing partition
    # Subvolumes must set a mountpoint in order to be mounted,
    # unless their parent is mounted
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
}
