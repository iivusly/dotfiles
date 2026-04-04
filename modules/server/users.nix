{ config, ... }:
{
  users.users."root" = {
    initialHashedPassword = "$y$j9T$daAEsGbw9jxaZBF3uGhym/$2ApFrwIRRKNzETMDlTEdFT2CAQmcAiryEZ9HE62Iyg7";
  };

  users.groups.storage = {};

  systemd.tmpfiles.rules = [
    "a+ /mnt/storage - - - - group:storage:rwx,default:group:storage:rwx"
  ];
}
