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

    git =
      with pkgs;
      with lib;
      {
        enable = true;
        userEmail = "ramy.tanios@gmail.com";
        userName = "Ramy Tanios";
        diff-so-fancy.enable = mkDefault false; # might want to override in machine specific module
        delta.enable = mkDefault false; # might want to override in machine specific module
        delta.options.side-by-side = mkDefault false; # might want to override in machine specific module
        extraConfig = {
          init.defaultBranch = "main";
        };
      };

  };

}
