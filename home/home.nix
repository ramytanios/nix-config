{ config, pkgs, ... }:

{
  # me 
  imports =
    [ ./fish/fish.nix ./tmux/tmux.nix ./kitty/kitty.nix ./nvim/nvim.nix ];

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
    packages = let
      hello-world = pkgs.writeShellScriptBin "hello-world" ''
        echo "Hello world, I am ${config.home.username}"
      '';

    in with pkgs; [
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
      hello-world
      ncdu
      scala-cli
      coursier
      sbt
      metals
      eza
      podman
      ripgrep
      tree
      gnumake
      nodejs
      jdk
      bat
      killall
      httpie
      fzf
      just
      thefuck
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

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "sbt" ];
      };
      initExtra = ''
        function _tmux()
        {
          # assumes there a session called `HOME` exists
          command tmux attach -t HOME \; choose-tree -s
        }
      '';
      shellAliases = { t = "_tmux"; };
    };

    bash = { enable = true; };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = { };
        editor = "nvim";
      };
    };

    ssh = { enable = true; };

    git = {
      enable = true;
      userEmail = "ramy.tanios@gmail.com";
      userName = "Ramy Tanios";
      diff-so-fancy.enable = true;
    };

    java = { enable = true; };

    # keychain = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   enableBashIntegration = true;
    #   enableZshIntegration = true;
    #   agents = [ "ssh" ];
    #   extraFlags = [ "--ignore-missing" "--quiet" ];
    # };

  };

  # services.ssh-agent.enable = true;

}
