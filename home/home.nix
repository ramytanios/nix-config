{ config, pkgs, ... }:
{

  imports = [
    ./tmux/tmux.nix
    ./kitty/kitty.nix
    ./nvim/nvim.nix
    ./fish/fish.nix
    ./zsh/zsh.nix
    ./git/git.nix
    ./ghostty/ghostty.nix
  ];

  home = {

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages =
      let
        hello-world = pkgs.writeShellScriptBin "hello-world" ''
          echo "Hello world, I am ${config.home.username}"
        '';

        python-packages =
          ps: with ps; [
            pydantic
            requests
            pandas
            numpy
            scipy
            matplotlib
            ipython
            scikit-learn
            seaborn
            statsmodels
            jupyterlab
            notebook
            joblib
            pytest
            yfinance
          ];

        python-with-packages = pkgs.python3.withPackages python-packages;

      in
      with pkgs;
      [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
        colima # "https://github.com/NixOS/nixpkgs/issues/47201#issuecomment-2041162985"
        coursier
        csvlens
        docker
        docker-compose
        lazydocker
        duf
        dummy-app
        eza
        fd
        figlet
        fx
        fzf
        glow
        gnumake
        gum
        hello-world
        httpie
        jdk
        just
        killall
        lazygit
        metals
        nodePackages.live-server
        ncdu
        nodejs
        podman
        postgresql
        pulsarctl
        python-with-packages
        redis
        ripgrep
        ruff
        sbt
        scala-cli
        stow
        #thefuck
        tldr
        tree
        treefmt
        tree-sitter
        websocat
        unzip
        uv
        zip
      ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/ramy/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  # Let Home Manager install and manage itself.
  programs = {

    home-manager.enable = true;

    java.enable = true;

    ssh.enable = true;

    bat.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    htop.enable = true;

    direnv = {
      enable = false;
      # enableFishIntegration = true; # enabled by default
      enableBashIntegration = true;
    };

    broot = {
      enable = true;
      enableFishIntegration = true;
      settings = { };
    };

  };

}
