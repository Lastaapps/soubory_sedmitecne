{
  description = "Supr čupr Nixí config";

  # To switch from stable to unstable or vice versa, change:
  # - pkgs and lib creation
  # - home-manager lib call
  # - vscode-extensions dependency
  # When you migrate to a new stable version,
  # try to remote all the pkgs-unstable usages.
  # Also, update version in ./system/configuration.nix.
  inputs = {
    nixpkgs-master.url = "nixpkgs/master";

    # Also update home.stateVersion bellow in the file
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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # polymc.url = "github:PolyMC/PolyMC";

    ############################################################################
    # NVim plugins
    # In case something is slightly changed after the first install (like '-' vs '.')
    # and plugin does not get loaded correctly (see plugins directory in :Lazy),
    # delete folder ~/.cache/nvim/luac
    nvimPlugin-amitds1997-remote-nvim-nvim = {
      url = "github:amitds1997/remote-nvim.nvim/bc39422f544e6f7b6b6cdeb0cc0e9aaa20398f5a";
      # url = "git+https://github.com/amitds1997/remote-nvim.nvim.git?ref=refs/tags/v0.3.11";
      flake = false;
    };
    nvimPlugin-robert-f-string-toggle-nvim = {
      url = "github:roobert/f-string-toggle.nvim";
      flake = false;
    };
    nvimPlugin-rayx-lsp-signature-nvim = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };
    nvimPlugin-iurimateus-luasnip-latex-snippets-nvim = {
      url = "github:iurimateus/luasnip-latex-snippets.nvim";
      flake = false;
    };
    nvimPlugin-monkoose-neocodeium = {
      url = "github:monkoose/neocodeium";
      flake = false;
    };
    nvimPlugin-nanotee-sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
    };
    nvimPlugin-cyberdream-nvim = {
      url = "github:scottmckendry/cyberdream.nvim";
      flake = false;
    };
    nvimPlugin-noctis-high-contrast-nvim = {
      url = "github:iagorrr/noctis-high-contrast.nvim";
      flake = false;
    };
  };

  outputs =
    { self, ... }@inputs: # @ binds values from inputs
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
      pkgs-master = import inputs.nixpkgs-master {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      lib = inputs.nixpkgs-stable.lib;

      # Creates a custom vim plugin
      # name must be the same as the repo name
      customVimPlugin =
        prev: input: author: repo:
        prev.vimUtils.buildVimPlugin {
          src = input;
          pname = repo;
          version = input.lastModifiedDate;
          meta.homepage = "https://github.com/" + author + "/" + repo + "/";
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
            inherit pkgs-master;
            inherit inputs;
          };

          modules = [
            {
              home.stateVersion = "24.11";
            }
            ./users/petr/home.nix
            {
              nixpkgs.overlays = [
                inputs.nix-vscode-extensions.overlays.default
                # inputs.polymc.overlay

                (final: prev: {
                  vimPlugins = {
                    remote-nvim =
                      (customVimPlugin prev inputs.nvimPlugin-amitds1997-remote-nvim-nvim "amitds1997" "remote-nvim.nvim")
                      .overrideAttrs
                        {
                          dontPatchShebangs = true;
                        };

                    f-string-toggle-nvim =
                      customVimPlugin prev inputs.nvimPlugin-robert-f-string-toggle-nvim "roobert"
                        "f-string-toggle.nvim";

                    iurimateus-luasnip-latex-snippets-nvim =
                      customVimPlugin prev inputs.nvimPlugin-iurimateus-luasnip-latex-snippets-nvim "iurimateus"
                        "luasnip-latex-snippets.nvim";

                    neocodeium = customVimPlugin prev inputs.nvimPlugin-monkoose-neocodeium "monkoose" "neocodeium";

                    sqls-nvim = customVimPlugin prev inputs.nvimPlugin-nanotee-sqls-nvim "nanotee" "sqls.nvim";

                    cyberdream-nvim =
                      customVimPlugin prev inputs.nvimPlugin-cyberdream-nvim "scottmckendry"
                        "cyberdream.nvim";

                    noctis-high-contrast-nvim =
                      customVimPlugin prev inputs.nvimPlugin-noctis-high-contrast-nvim "iagorrr"
                        "noctis-high-contrast.nvim";
                    lsp-signature-nvim =
                      customVimPlugin prev inputs.nvimPlugin-rayx-lsp-signature-nvim "ray-x"
                        "lsp_signature.nvim";
                  } // prev.vimPlugins;
                })
              ];
            }
          ];
        };
      };
    };
}
