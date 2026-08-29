{
  description = "NixOS Hyprland";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs = inputs @ {
    self,
    nixpkgs, 
    hyprland,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86-64-linux";
      specialArgs = { inherit inputs;};
      modules = [
        ./configuration.nix	
        ./hardware-configuration.nix
      ];
    };
  };
}
