{ pkgs }:

let shell = import ./aliases.nix { inherit pkgs; };

in {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
    shellAliases = shell.aliases // { t = "_tmux"; };
    inherit (shell) initExtra;
  };
}
