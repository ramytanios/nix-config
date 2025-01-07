{ pkgs, ... }:
{

  system.stateVersion = 5;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # automatic garbage collection
    # https://nixos.wiki/wiki/Storage_optimization
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
      user = "ramytanios";
    };

  };

  system = {
    defaults = {

      dock = {
        autohide = true;
        static-only = false; # dont show only running apps, but all
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };

      NSGlobalDomain = {

        ApplePressAndHoldEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false; # disable automatic spelling correction

        # enable "natural" scroll direction
        "com.apple.swipescrolldirection" = true;

        # key repeat: lower is faster
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
      };

    };
  };

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  # Enable sudo authentication with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  nix.package = pkgs.nix; # this is the default

  networking.hostName = "macbook-air-m2";

  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    # kitty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  # homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      "discord"
      "docker"
      "firefox"
      "kitty"
      "telegram"
      "whatsapp"
    ];
  };

  # ZSH
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  users.users.ramytanios = {
    name = "ramytanios";
    home = "/Users/ramytanios";
  };
}
