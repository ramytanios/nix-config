{ pkgs, ... }:
{
  programs = {

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = { };
        editor = "nvim";
        version = 1; # see issue https://github.com/cli/cli/issues/8462
      };
    };

    git = {
      enable = true;
      settings = {
        user.email = "ramy.tanios@gmail.com";
        user.name = "Ramy Tanios";
        init.defaultBranch = "main";
      };
    };

    diff-so-fancy = with pkgs.lib; {
      enable = mkDefault false; # might want to override in machine specific module
    };

    delta = with pkgs.lib; {
      enable = mkDefault false; # might want to override in machine specific module
      options.side-by-side = mkDefault false; # might want to override in machine specific module
    };

  };

}
