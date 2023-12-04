{ pkgs, ... }: {

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = 11.0;
    extraConfig = ''
      cursor_shape  block
      shell_integration no-cursor
      hide-window-decorations yes
    '';
    theme = "Tokyo Night Storm";
  };

}
