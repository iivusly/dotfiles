{ globals, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      user = {
        name = "${globals.user}";
        email = "${globals.github-email}";
        signingkey = "0D0F15B7848CF419";
      };
      commit.gpgsign = true;
    };

    ignores = [ ".DS_Store" ];
  };
}
