# nix-config

Nix flake managing home-manager and nix-darwin configurations across multiple machines.

## Structure

- `flake.nix` — entry point; defines machines, home configs, darwin configs, and flake apps
- `home/` — home-manager modules per tool (nvim, tmux, fish, git, etc.)
  - `home.nix` — shared home config imported by all machines
  - `home-<machine>.nix` — per-machine overrides
- `system/` — NixOS / nix-darwin system configurations

## Machines

| Name | System |
|------|--------|
| `macbook-air-m2` | aarch64-darwin |
| `multipass-guest` | aarch64-linux |
| `multipass-guest-x86` | x86_64-linux |
| `wsl` | x86_64-linux |

## Flake outputs

| Output | Description |
|--------|-------------|
| `homeConfigurations.<machine>` | Home-manager config per machine |
| `darwinConfigurations.<machine>` | nix-darwin system config (macbook-air-m2) |
| `nixosConfigurations.<machine>` | NixOS system config (multipass guests) |
| `apps.<system>.hm-switch-<machine>` | Apply home-manager config |
| `apps.<system>.rebuild-<machine>` | Apply system (darwin/nixos) config |
| `apps.<system>.clean-<machine>` | Garbage collect (>15 days) |
| `devShells.<system>.default` | Dev shell with Lua and Nix tooling |

## Applying changes

```bash
# Home manager
nix run .#hm-switch-<machine>

# Darwin
nix run .#rebuild-<machine>

# Garbage collect
nix run .#clean-<machine>
```
