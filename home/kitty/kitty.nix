{ ... }:
{

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    extraConfig = ''
      cursor_shape block
      hide_window_decorations titlebar-only
    '';
  };

}
