{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEh1KwHn5up7zMoXxZoYpD2W4NCafK4WSJHMESBd6cKz iivusly"
  ];
}
