# My personal Nix configuration flake.

Nix configuration flake for my personal machines (macOS and NixOS).

❗*I am a complete Nix beginner -- don't blindly copy paste*

⌛*This is work in progress!*

💡*Heavily inspired by* [buntec](https://github.com/buntec/nix-config)

## Fresh NixOS install
After installing NixOS from a USB drive, follow these steps:

1. Clone this repo and `cd` into it.

2. Copy `/etc/nixos/hardware-configuration.nix` into `./system` (OK to overwrite existing dummy file).

3. Finally, to build and activate in one step using the `apps` provided by the flake
```bash
nix run .#rebuild-nixos # system configuration
nix run .#hm-switch-nixos # dotfiles and home configuration
```

## Fresh macOS install
(Heavily inspired by this [gist](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050))

To bootstrap a fresh macOS install, follow these steps:

1. Install Homebrew (only needed for managing GUI apps via casks)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install Nix:
```bash
curl -L https://nixos.org/nix/install | sh
```

3. Enable flakes
```bash
mkdir -p ~/.config/nix
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

4. To work around this [issue](https://github.com/LnL7/nix-darwin/issues/149)
```bash
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

5. Clone this repo, `cd` into it, then build and activate with the following commands:
```bash
nix run .#rebuild-macbook-air-m2 # system configuration
nix run .#hm-switch-macbook-air-m2 # dotfiles and home configuration
```

## Migrating an existing macOS install to Nix
1. Uninstall Homebrew:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

2. Delete everything under `~/.config` and any other "dot files" in your home directory.

3. Delete all applications that are listed as Homebrew casks in `./system/configuration-darwin.nix`

4. Follow the steps for a fresh macOS install.
