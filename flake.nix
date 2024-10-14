{
  description = "Supr čupr Nixí config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, nix-vscode-extensions, ...} @ inputs: # @ binds values from inputs
  let
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config = { allowUnfree = true; };
    };
    

    lib = inputs.nixpkgs.lib;
  in {
    nixosConfigurations = {
      msi = lib.nixosSystem {
        inherit system;

        modules = [
          ./system/configuration.nix ./devices/msi/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      petr = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/petr/home.nix
          {
            nixpkgs.overlays = [
              inputs.nix-vscode-extensions.overlays.default
            ];
          }
        ];
      };
    };
  };
}
