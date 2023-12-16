hm: 
	home-manager switch --flake .#ramyt@nixos

nixos:
	sudo nixos-rebuild switch --flake .#nixos

clean:
	sudo nix-collect-garbage --delete-older-than 15d
