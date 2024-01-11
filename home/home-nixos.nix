{ inputs, ... }: {
  imports = [ inputs.colorscheme.homeModules.default.tokyonight ];

  # Tokyonight colorscheme
  colorscheme.tokyonight = {
    style = "storm";
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  # kitty font specification
  programs.kitty.font.size = 12.5;
}
