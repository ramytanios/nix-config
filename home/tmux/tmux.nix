{ pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    clock24 = true;
    mouse = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      prefix-highlight
      vim-tmux-navigator
      resurrect
      tmux-fzf
    ];
    extraConfig = ''
      ${builtins.readFile ./extra.conf}
    '';
  };

}
