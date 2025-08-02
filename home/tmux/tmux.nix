{ pkgs, ... }:
{

  programs.tmux = with pkgs; {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    shell = "${fish}/bin/fish";
    clock24 = true;
    mouse = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = with tmuxPlugins; [
      prefix-highlight
      vim-tmux-navigator
      resurrect
      tmux-fzf
      gitmux
    ];
    extraConfig = builtins.readFile ./extra.conf;
  };

}
