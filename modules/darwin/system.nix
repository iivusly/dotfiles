{
  pkgs,
  ...
}:
{
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults.dock.persistent-apps = [
    { app = "/System/Applications/Apps.app"; }
    { app = "/Applications/Chromium.app"; }
    { app = "${pkgs.telegram-desktop}/Applications/Telegram.app"; }
    { app = "${pkgs.vesktop}/Applications/Vesktop.app"; }
    { app = "${pkgs.element-desktop}/Applications/Element.app"; }
    { app = "/Applications/WhatsApp.app"; }
    { app = "/Applications/Thunderbird.app"; }
    { app = "${pkgs.supersonic}/Applications/Supersonic.app"; }
    { app = "${pkgs.alacritty}/Applications/Alacritty.app"; }
  ];
}
