{ inputs, ... }: {
  imports = [ inputs.tokyonight.homeModules.default ];
  colorschemes.tokyonight.enable = true;
  colorschemes.tokyonight.variant = "storm";
}
