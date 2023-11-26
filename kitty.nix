{ pkgs, ... }: {

  programs.kitty = {
    enable = true; 
    font.name = "FiraCode Nerd Font";
    font.size = 11.0;
    extraConfig = ''
      cursor_shape  block
      shell_integration no-cursor
      hide-window-decoration yes
    '';
    theme = "Tokyo Night Storm";
  };

}
