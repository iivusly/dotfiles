{ lib, ... }: {
  services.flatpak = {
    packages = [
      "org.vinegarhq.Sober"
      "com.spotify.Client"
    ];
  };
}
