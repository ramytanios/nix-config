{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    clock24 = true;
    mouse = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator resurrect];
    extraConfig = ''
      set -g @resurrect-capture-pane-contents 'on';
      set -g @resurrect-strategy-nvim 'session';
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      bind -r m resize-pane -Z
      unbind '"'
      bind-key s choose-tree -ZsN
      bind - split-window -v
      unbind %
      bind | split-window -h
      set -g mouse on
    '';
  };

}
