{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # (pkgs.callPackage ./prismlauncher.nix { })

    # Old patched PolyMC client
    # (polymc.overrideAttrs (old: rec {
    #   src = fetchFromGitHub {
    #     owner = "dev-null-undefined";
    #     repo = "PolyMC";
    #     rev = "a9717e5d3ac379fd46eedac86655b31c831a7dd7";
    #     sha256 = "sha256-Ji/Xa+jv0LEGsKttat9heyaSPCgZTYpVc0ZOA4evpVQ=";
    #     fetchSubmodules = true;
    #   };
    # }))
  ];
}
