{ pkgs, ... }:

################################################################################
# # Documentation for flakes
#
# disable nix using a flake:
# https://docs.haskellstack.org/en/v2.11.1/nix_integration/
#
# Prebuilt GHC
# https://input-output-hk.github.io/haskell.nix/tutorials/getting-started-flakes.html
#
# GHC version to LTS snapshot version
# https://www.stackage.org/#about
# LTS 23.11 for ghc-9.8.4
# LTS 22.43 for ghc-9.6.6
# LTS 21.25 for ghc-9.4.8
################################################################################

{
  home.packages = [
    (pkgs.haskell.packages.ghc966.ghcWithPackages (hPkgs: [
      hPkgs.haskell-language-server
      hPkgs.ghcid # Continuous terminal Haskell compile checker
      hPkgs.ormolu # Haskell formatter
      hPkgs.hlint # Haskell codestyle checker
      hPkgs.hoogle # Lookup Haskell documentation
      hPkgs.haskell-language-server # LSP server for editor
      hPkgs.implicit-hie # auto generate LSP hie.yaml file from cabal
      hPkgs.retrie # Haskell refactoring tool
      hPkgs.cabal-install

      # Stack installed this way ignores with which version it was installed.
      # When it is first run it creates a config file
      # `~/.stack/global-project/stack.yaml`. In it there is a line like
      # `snapshot: lts-23.9`. This defines the version stack uses unless
      # specified using the `--compiler ghc-9.6.6` or `--snapshot 22.43`
      # option. If related version of GHC is still not available using Nix
      # packages, stack fails while executing any command. If this happens,
      # follow the instructions bellow:
      #
      # How to create a project:
      # - Run `stack init --compiler ghc966` or `stack new template_name ghc966`
      # - Change the snapshot filed the newly generated `stack.yaml` file to your compiler version.
      # - Enjoy. Commands should use the correct versions now.
      hPkgs.stack

      # Unsuccessful attempt to patch the stack client
      # Left as a documentation how patching works
      # (hPkgs.stack.overrideAttrs (old: {
      #   buildInputs = old.buildInputs ++ [
      #     pkgs.dos2unix
      #   ];
      #   # The repository is cloned using CRLF for some reason.
      #   # Therefore, my Unix LF patch file is not compatible.
      #   # Either the patch file has to be converted to CRLF using unix2dos
      #   # and the patch command needs to be notified not to strip CR (--binary),
      #   # or all the target files need to be converted to LF using dos2unix.
      #   patchPhase =
      #     ''
      #       # # Also run unix2dos on your patch file
      #       # patch -p1 --binary < ${./stack.patch}

      #       dos2unix src/Stack/Nix.hs
      #       dos2unix src/Stack/Setup.hs
      #       patch -p1 < ${./stack.patch}
      #     ''
      #     + (old.patchPhase or '''');
      # }))
    ]))
  ];
}
