{ inputs, pkgs, ... }:
{

  catppuccin =
    let
      flavor = "frappe";
    in
    {
      enable = true;
      inherit flavor;
      tmux.enable = false;
      zsh-syntax-highlighting.enable = true;
      zsh-syntax-highlighting.flavor = flavor;
    };

  programs = {

    kitty.font.size = 15.5;

    git.diff-so-fancy.enable = true;

  };

}
