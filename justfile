@default:
    just --list

host := `hostname`

[unix]
fmt:
    just --fmt --unstable

[unix]
switch:
    nix run .#hm-switch-{{ host }}

[unix]
rebuild:
    nix run .#rebuild-{{ host }}

[unix]
clean:
    nix run .#clean-{{ host }}
