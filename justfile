@default:
    just --list

host := `hostname`

[unix]
fmt:
    just --fmt --unstable

[unix]
reload-tmux:
    tmux source-file ~/.config/tmux/tmux.conf

[unix]
reload-fish:
    fish -c 'source ~/.config/fish/**/*.fish'

[unix]
switch:
    nix run .#hm-switch-{{ host }}
    just reload-tmux 
    just reload-fish

[unix]
rebuild:
    sudo nix run .#rebuild-{{ host }}

[unix]
clean:
    nix run .#clean-{{ host }}

[unix]
flake-update:
    nix flake update

[unix]
inspect-flake:
    nix repl --expr "let flake = builtins.getFlake (toString $PWD); in {inherit flake;}"

[unix]
develop:
    nix develop --no-pure-eval
