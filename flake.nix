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

    # polymc.url = "github:PolyMC/PolyMC";

    # NVim plugins
    nvimPlugings-robert-f-string-toggle-nvim = {
      url = "github:roobert/f-string-toggle.nvim";
      flake = false;
    };
    nvimPlugings-iurimateus-luasnip-latex-snippets-nvim = {
      url = "github:iurimateus/luasnip-latex-snippets.nvim";
      flake = false;
    };
    nvimPlugings-monkoose-neocodeium = {
      url = "github:monkoose/neocodeium";
      flake = false;
    };
    nvimPlugings-nanotee-sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
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

      # Creates a custom vim plugin
      # name must be the same as the repo name
      customVimPlugin =
        prev: input: name:
        prev.vimUtils.buildVimPlugin {
          src = input;
          pname = name;
          version = input.lastModifiedDate;
        };
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
            inherit inputs;
          };

          modules = [
            ./users/petr/home.nix
            {
              nixpkgs.overlays = [
                inputs.nix-vscode-extensions.overlays.default
                # inputs.polymc.overlay

                (final: prev: {
                  vimPlugins = {
                    f-string-toggle-nvim =
                      customVimPlugin prev inputs.nvimPlugings-robert-f-string-toggle-nvim
                        "f-string-toggle-nvim";

                    iurimateus-luasnip-latex-snippets-nvim =
                      customVimPlugin prev inputs.nvimPlugings-iurimateus-luasnip-latex-snippets-nvim
                        "luasnip-latex-snippets-nvim";

                    neocodeium = customVimPlugin prev inputs.nvimPlugings-monkoose-neocodeium "neocodeium";

                    sqls-nvim = customVimPlugin prev inputs.nvimPlugings-nanotee-sqls-nvim "sqls-nvim";
                  } // prev.vimPlugins;
                })
              ];
            }
          ];
        };
      };
    };
}
