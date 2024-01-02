{ inputs, ... }: {
  imports = [ inputs.tokyonight.homeModules.colorscheme ];

  # Tokyonight colorscheme
  colorscheme.tokyonight = {
    variant = "storm";
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  # kitty font specification
  programs.kitty.font.size = 12.5;
}
