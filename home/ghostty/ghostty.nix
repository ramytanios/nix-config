{ pkgs, ... }:
{

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.ghostty; # currently marked broken on Darwin
    settings = {
      font-size = 15;
      font-family = "JetBrainsMono Nerd Font Mono";
      font-thicken = true;
      font-thicken-strength = 200;
      cursor-style = "block";
      shell-integration = "fish";
      mouse-hide-while-typing = true;
      window-save-state = "always";
    };
  };

}
