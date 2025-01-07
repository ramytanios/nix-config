{ inputs, ... }:
{

  imports = [ inputs.tokyonight.homeModules.colorscheme ];

  colorscheme.tokyonight = {
    style = "storm";
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  programs = {

    kitty.font.size = 12.5;

    git.delta = {
      enable = true;
      options.side-by-side = true;
    };

  };

}
