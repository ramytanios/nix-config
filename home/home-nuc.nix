{ inputs, ... }:
{
  imports = [ inputs.colorscheme.homeModules.default.kauz ];

  colorscheme.kauz = {
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  programs.kitty.font.size = 12.5;
}
