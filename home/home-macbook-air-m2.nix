{ inputs, pkgs, ... }:
{
  # imports = [ inputs.tokyonight.homeModules.colorscheme ];

  # colorscheme.tokyonight = {
  #   style = "storm";
  #   fish.enable = true;
  #   tmux.enable = true;
  #   kitty.enable = true;
  #   neovim.enable = true;
  # };

  programs.tmux.catppuccin.enable = false;
  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  programs.kitty.font.size = 15.5;

}
