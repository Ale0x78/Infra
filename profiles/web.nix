{ config, lib, pkgs, home-manager, ... }:
{
    programs.firefox.enable = true;
    # nixpkgs.overlays =
    #   let
    #     # Change this to a rev sha to pin
    #     moz-rev = "master";
    #     moz-url = builtins.fetchTarball {
    #       url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
    #       sha256 = "3855a092aee691f37b373a1ab626c30b17d33415277f4717c3d802eccb2e7f76";
    #       };

    #     nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
    #   in [
    #     nightlyOverlay
    #   ];
    # programs.firefox.package = pkgs.latest.firefox-nightly-bin;
    environment.systemPackages = with pkgs; [
        # firefox
        brave
      ];
}
