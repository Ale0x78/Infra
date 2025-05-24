{ config, lib, pkgs, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
      firefox
    ];
    nixpkgs.overlays =
      let
        # Change this to a rev sha to pin
        moz-rev = "master";
        moz-url = builtins.fetchTarball {
          url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
          sha256 = "0fcfg835ly29m7m4xzhxb7lvw2ayxcv7cn7pzw4hkj2j1vzx7b2b";
          };

        nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
      in [
        nightlyOverlay
      ];
    programs.firefox.package = pkgs.latest.firefox-nightly-bin;
}
