{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 11.5;
    extraConfig = ''
      cursor_shape  block
      shell_integration no-cursor
      hide_window_decorations no
    '';
    theme = "Tokyo Night Storm";
  };

}
