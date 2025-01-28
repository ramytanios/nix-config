{ pkgs, ... }:
{

  programs.kitty = with pkgs; {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = lib.mkDefault 14; # might want to override in machine-specific module
    extraConfig = builtins.readFile ./extra.conf;
  };

}
