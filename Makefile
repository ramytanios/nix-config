hm: 
	home-manager switch --flake .#ramyt@nixos

nixos:
	sudo nixos-rebuild switch --flake .#nixos
