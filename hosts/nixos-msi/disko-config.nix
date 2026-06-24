{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL21T0HCLR-00B00_S676NX0RA39235_1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF00";
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
    };
  };
}
