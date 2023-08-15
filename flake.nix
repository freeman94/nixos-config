{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }@inputs: {
    nixosModules = {
      base = import ./base.nix;
      wireless = import ./wireless.nix;
      nvidia = import ./nvidia.nix;
      ledger = import ./ledger.nix;
    };

    nixosConfigurations = {
      jhf-main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.base
          self.nixosModules.nvidia
          self.nixosModules.ledger
          ./main/configuration.nix
          ./main/hardware-configuration.nix
        ];
      };

    };
  };
}
