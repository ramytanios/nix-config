{ pkgs, ... }:

let
  core = import ./core.nix { inherit pkgs; };

in
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
    shellAliases = core.shellAliases // {
      t = "_tmux";
    };
    inherit (core) initExtra;
  };
}
