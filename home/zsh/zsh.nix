{ pkgs, ... }:

{
  programs.zsh = {

    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      t = "tmux attach -t HOME";
      lg = "lazygit";
    };
    initContent = pkgs.lib.mkOrder 1000 "bindkey '$' autosuggest-accept";

    prezto = {
      enable = true;
      prompt.theme = "pure";
    };

  };
}
