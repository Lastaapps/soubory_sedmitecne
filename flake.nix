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

    # NVim plugins
    nvimPlugings-luasnip-latex-snippets-nvim = {
      url = "github:evesdropper/luasnip-latex-snippets.nvim";
      flake = false;
    };
    nvimPlugings-f-string-toggle-nvim = {
      url = "github:roobert/f-string-toggle.nvim";
      flake = false;
    };
    nvimPlugings-sqls-nvim = {
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

      nvimCustomPluins = {
        luasnip-latex-snippets-nvim = import inputs.nvimPlugings-luasnip-latex-snippets-nvim;
        f-string-toggle-nvim = import inputs.nvimPlugings-f-string-toggle-nvim;
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
            inherit inputs;
            inherit nvimCustomPluins;
          };

          modules = [
            ./users/petr/home.nix
            {
              nixpkgs.overlays = [
                inputs.nix-vscode-extensions.overlays.default

                (final: prev: {
                  vimPlugins = {
                    luasnip-latex-snippets-nvim = prev.vimUtils.buildVimPlugin {
                      src = inputs.nvimPlugings-luasnip-latex-snippets-nvim;
                      name = "luasnip-latex-snippets-nvim";
                    };
                    f-string-toggle-nvim = prev.vimUtils.buildVimPlugin {
                      src = inputs.nvimPlugings-f-string-toggle-nvim;
                      name = "f-string-toggle-nvim";
                    };
                    sqls-nvim = prev.vimUtils.buildVimPlugin {
                      src = inputs.nvimPlugings-sqls-nvim;
                      name = "sqls-nvim";
                    };
                  } // prev.vimPlugins;
                })
              ];
            }
          ];
        };
      };
    };
}
