{ config, ... }:
{
  users.users."root" = {
    initialHashedPassword = "$y$j9T$daAEsGbw9jxaZBF3uGhym/$2ApFrwIRRKNzETMDlTEdFT2CAQmcAiryEZ9HE62Iyg7";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEh1KwHn5up7zMoXxZoYpD2W4NCafK4WSJHMESBd6cKz iivusly"
    ];
  };

  users.groups.storage = {};

  systemd.tmpfiles.rules = [
    "a+ /mnt/storage - - - - group:storage:rwx,default:group:storage:rwx"
  ];
}
