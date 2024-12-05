{
  description = "Supr čupr Nixí config";

  # To switch from stable to unstable or vice versa, change:
  # - pkgs and lib creation
  # - home-manager lib call
  # - vscode-extensions dependency
  # When you migrate to a new stable version,
  # try to remote all the pkgs-unstable usages
  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      nixpkgs-unstable,
      home-manager-stable,
      home-manager-unstable,
      nix-vscode-extensions,
      ...
    }@inputs: # @ binds values from inputs
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      lib = inputs.nixpkgs-stable.lib;
    in
    {
      nixosConfigurations = {
        msi = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs-stable;
            inherit pkgs-unstable;
          };

          modules = [
            ./system/configuration.nix
            ./devices/msi
          ];
        };
      };

      homeConfigurations = {
        petr = inputs.home-manager-stable.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit pkgs-unstable;
          };

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
