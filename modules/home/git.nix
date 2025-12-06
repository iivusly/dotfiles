{ globals, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      user = {
        name = "${globals.user}";
        email = "${globals.github-email}";
      };
    };

    ignores = [ ".DS_Store" ];
  };
}
