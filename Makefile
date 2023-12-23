# Should be added to the flake (assumes make is not available)
hm-nuc: 
	nix run home-manager -- switch --flake .#nuc

hm-macbook:
	nix run home-manager -- switch --flake .#macbook-air-m2

nixos:
	sudo nixos-rebuild switch --flake .#nixos

clean:
	sudo nix-collect-garbage --delete-older-than 15d
