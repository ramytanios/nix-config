{ inputs, pkgs, ... }: {
  imports = [ inputs.tokyonight.homeModules.colorscheme ];

  colorscheme.tokyonight = {
    style = "storm";
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  # kitty font specification
  programs.kitty.font.size = 15.5;

  home.packages = with pkgs; [ texlive.combined.scheme-full ];

}
