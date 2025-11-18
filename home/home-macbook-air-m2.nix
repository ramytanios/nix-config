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

      nvim.settings = {
        transparent_background = true;
      };

      zsh-syntax-highlighting.enable = true;
      zsh-syntax-highlighting.flavor = flavor;

    };

  programs = {

    kitty.font.size = 15.5;

    git.diff-so-fancy.enable = true;

  };

}
