@default:
    just --list

host := `hostname`

fmt:
    just --fmt --unstable

reload-tmux:
    tmux source-file ~/.config/tmux/tmux.conf

reload-fish:
    fish -c 'source ~/.config/fish/**/*.fish'

switch:
    nix run .#hm-switch-{{ host }}
    just reload-tmux 
    just reload-fish

rebuild:
    sudo nix run .#rebuild-{{ host }}

clean:
    nix run .#clean-{{ host }}

flake-update:
    nix flake update

inspect-flake:
    nix repl --expr "let flake = builtins.getFlake (toString $PWD); in {inherit flake;}"

develop:
    nix develop --no-pure-eval

create-multipass-instance:
    multipass launch -n nix -c 1 -m 8G -d 128G --mount ~:/home/ramytanios/host --cloud-init extras/multipass-cloud-init.yml

ssh-nix:
    ssh $(multipass info nix | grep IPv4 | awk '{print $2}')
