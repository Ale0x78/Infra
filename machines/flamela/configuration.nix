{ config, lib, pkgs, home-manager, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      home-manager.nixosModules.home-manager

      ../../services/comms.nix
      ../../services/boot.nix
      ../../services/jellyfin.nix
      ../../services/localSSH.nix
      ../../services/grafana.nix
      ../../services/adguard.nix

      ../../users/alex.nix

      ../../profiles/nixos-pkgs.nix
      ../../profiles/thebasics.nix
      ../../profiles/virtual.nix
      ../../profiles/dev.nix
    ];

  time.timeZone = "US/Eastern";
  networking.hostId = "5677ca84";

  networking = {
    interfaces = {
      enp4s0.ipv4.addresses = [{
      address = "192.168.86.24";
      prefixLength = 24;
      }];
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment? No I deleted it; tldr, do not remove

}
