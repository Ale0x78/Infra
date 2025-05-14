{ config, lib, pkgs, home-manager, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      home-manager.nixosModules.home-manager

      ../../services/comms.nix
      ../../services/boot.nix
      ../../services/jellyfin.nix

      ../../users/alex.nix

      ../../profiles/nixos-pkgs.nix
      ../../profiles/thebasics.nix
      ../../profiles/virtual.nix
      ../../profiles/dev.nix
    ];

  time.timeZone = "US/Eastern";
  networking.hostId = "5677ca84";


  system.stateVersion = "25.05"; # Did you read the comment? No I deleted it; tldr, do not remove

}
