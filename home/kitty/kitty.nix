{ ... }: {

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    # font.size = 15.5; # override for each machine
    extraConfig = ''
      cursor_shape  block
      shell_integration no-cursor
      hide_window_decorations no
    '';
  };

}
