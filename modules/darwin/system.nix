{
  config,
  pkgs,
  ...
}:
{
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults.dock.persistent-apps = [
    { app = "/System/Applications/Apps.app"; }
    {
      app = "${
        config.home-manager.users.${config.user}.programs.firefox.package
      }/Applications/Firefox.app";
    }
    { app = "${pkgs.telegram-desktop}/Applications/Telegram.app"; }
    { app = "/Applications/WhatsApp.app"; }
    { app = "${pkgs.thunderbird}/Applications/Thunderbird.app"; }
    { app = "${pkgs.supersonic}/Applications/Supersonic.app"; }
    { app = "${pkgs.alacritty}/Applications/Alacritty.app"; }
  ];
}
