{
  disko.devices = {
    disk = {
      internal = {
        device = "/dev/disk/by-id/mmc-DA4032_0x344bc924";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              type = "EF00";
              size = "512M";
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
      external = {
        device = "/dev/disk/by-id/usb-ST950032_5AS_WD-WX11A31Z1140-0:0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            primary = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/HDD";
                mountOptions = [ "defaults" "nofail" ];
              };
            };
          };
        };
      };
    };
  };
}
