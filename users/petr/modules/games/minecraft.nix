{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Patches the Minecraft launcher to support offline accounts
    # without buying the official version
    # Theoretical test only
    (prismlauncher-unwrapped.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./prismlauncher.patch
      ];
    }))
  ];
}
