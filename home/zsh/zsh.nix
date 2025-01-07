{ pkgs, ... }:

{
  programs.zsh = {

    enable = true;

    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

  };
}
