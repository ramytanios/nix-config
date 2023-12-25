{ inputs, ... }: {
  imports = [ inputs.tokyonight.homeModules.colorscheme ];
  colorscheme.tokyonight.enable = true;
  colorscheme.tokyonight.variant = "storm";

  # kitty font specification
  programs.kitty.font.size = 12.5;
}
