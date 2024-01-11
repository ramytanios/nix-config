{ inputs, pkgs, ... }: {
  imports = [ inputs.kauz.homeModules.default ];

  # Kauz colorscheme 
  kauz = {
    fish.enable = true;
    tmux.enable = true;
    kitty.enable = true;
    neovim.enable = true;
  };

  # kitty font specification
  programs.kitty.font.size = 15.5;

  # home.packages = with pkgs; [ texlive.combined.scheme-full ];

}
