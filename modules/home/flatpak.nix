{ lib, ... }: {
  services.flatpak = {
    packages = [
      "org.vinegarhq.Sober"
    ];
  };
}
