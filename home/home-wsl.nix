{ ... }:
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

    git.diff-so-fancy.enable = true;

    # correct vim colors on Windows Terminal (WSL)
    tmux.extraConfig = "set -as terminal-overrides ',*:Tc'";

  };

}
