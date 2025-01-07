{ inputs, pkgs, ... }:
{

  catppuccin = {
    enable = true;
    flavor = "frappe";
    tmux.enable = false;
  };

  programs = {

    kitty.font.size = 15.5;

    git.diff-so-fancy.enable = true;

  };

}
