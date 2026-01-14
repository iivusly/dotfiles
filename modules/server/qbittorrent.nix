{config, pkgs, ...}: {
  sops.secrets.qbittorrent_env = {
    owner = "qbittorrent";
    sopsFile = ./secrets.yaml;
  };

  systemd.services.qbittorrent = {
    serviceConfig.EnvironmentFile = [ config.sops.secrets.qbittorrent_env.path];

    preStart = with pkgs; ''
      CONF_FILE="${config.services.qbittorrent.profileDir}qBittorrent/config/qBittorrent.conf"
      if [ -f "$CONF_FILE" ] && ${gnugrep}/bin/grep -q "PLACEHOLDER_" "$CONF_FILE"; then
        # generating hashed password
        QBT_WEBUI_PASSWORD=$(${python3}/bin/python3 -c "import hashlib, os, base64; p='$QBT_WEBUI_PASSWORD'.encode(); s=os.urandom(16); h=hashlib.pbkdf2_hmac('sha512', p, s, 100000, 64); print(f'@ByteArray({base64.b64encode(s).decode()}:{base64.b64encode(h).decode()})')")

        ${gnused}/bin/sed -i "s|PLACEHOLDER_WEBUI_USERNAME|$QBT_WEBUI_USERNAME|g" "$CONF_FILE"
        ${gnused}/bin/sed -i "s|PLACEHOLDER_WEBUI_PASSWORD|$QBT_WEBUI_PASSWORD|g" "$CONF_FILE"
        ${gnused}/bin/sed -i "s|PLACEHOLDER_PROXY_USERNAME|$QBT_PROXY_USERNAME|g" "$CONF_FILE"
        ${gnused}/bin/sed -i "s|PLACEHOLDER_PROXY_PASSWORD|$QBT_PROXY_PASSWORD|g" "$CONF_FILE"
      fi
    '';
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 1337;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          Username = "PLACEHOLDER_WEBUI_USERNAME";
          Password_PBKDF2 = "PLACEHOLDER_WEBUI_PASSWORD";
        };
      };
      Network.Proxy = {
        AuthEnabled = true;
        HostnameLookupEnabled = true;
        Type = "SOCKS5";
        Username = "PLACEHOLDER_PROXY_USERNAME";
        Password = "PLACEHOLDER_PROXY_PASSWORD";
        IP = "los-angeles.us.socks.nordhold.net";
        Port = 1080;
        Profiles = {
          BitTorrent = true;
          Misc = true;
          RSS = false;
        };
      };
    };
  };
}
