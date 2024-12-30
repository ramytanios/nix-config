{ pkgs, ... }:
{

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

  system.defaults.dock.autohide = true;
  system.defaults.dock.static-only = false; # dont show only running apps, but all
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  # disable automatic spelling correction
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # enable "natural" scroll direction
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;

  # key repeat: lower is faster
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

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

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "DroidSansMono"
      ];
    })
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
