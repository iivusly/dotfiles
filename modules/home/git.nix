{ globals, ... }:
{
  programs.git = {
    enable = true;

    settings.user = {
      name = "${globals.user}";
      email = "${globals.github-email}";
    };

    ignores = [ ".DS_Store" ];
  };
}
