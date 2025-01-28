{ ... }:

{
  programs.zsh = {

    enable = true;

    autosuggestion.enable = true;

    syntaxHighlighting.enable = true;

    shellAliases = {
      t = "tmux attach -t HOME";
    };

  };
}
