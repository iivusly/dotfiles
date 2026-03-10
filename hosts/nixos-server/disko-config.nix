{
  disko.devices = {
    disk = {
      internal = {
        device = "/dev/disk/by-id/mmc-DA4032_0x344bc924";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              priority = 2;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              end = "-4G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "100%";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };
          };
        };
      };
      sabrent = {
        device = "/dev/disk/by-id/usb-SABRENT_SABRENT_DB9876543214E-0:0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            storage = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/storage";
                mountOptions = [ "nofail" ];
              };
            };
          };
        };
      };
    };
  };
}
