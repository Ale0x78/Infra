{ config, lib, pkgs, ... }:

{
  networking.firewall.enable = true;
  services.tailscale.enable = true;
}