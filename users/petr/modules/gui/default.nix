{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./browser.nix
    ./flameshot.nix
    ./gtk.nix
    ./nextcloud-client
    ./safeeyes
    ./social.nix
    ./zeal.nix
  ];
  home.packages = with pkgs; [
    anki-bin
    filezilla
    persepolis
    gparted
    postman
    qbittorrent-enhanced
    pear-desktop # youtube-music
    # inputs.just-another-music-player.packages.${pkgs.stdenv.hostPlatform.system}.default
    (inputs.just-another-music-player.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
      (oldAttrs: {
        npmDeps = pkgs.fetchNpmDeps {
          src = oldAttrs.src;
          # hash = "sha256-9hg4pqlTNm7YEf3KMbrruN4DKFelh+wkRVnoMgTvi4g=";
          hash = "sha256-JC2bcp3NzFnZVS/iqMrHRHzliMFGxjp4tfNPN3DDvwA=";
          forceGitDeps = true;
        };
      })
    )
    thunderbird
    ventoy-full
    yt-dlg

    # C# / Xamarin decompiler
    # ilspycmd
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];
}
