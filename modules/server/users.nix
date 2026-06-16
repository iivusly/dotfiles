{ config, ... }:
{
  users.groups.storage = { };

  users.users."root" = {
    extraGroups = [ "storage" ];
    initialHashedPassword = "$y$j9T$daAEsGbw9jxaZBF3uGhym/$2ApFrwIRRKNzETMDlTEdFT2CAQmcAiryEZ9HE62Iyg7";
  };

  systemd.tmpfiles.rules = [
    "d /mnt/storage 0770 root storage -"
  ];
}
