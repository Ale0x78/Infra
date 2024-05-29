{ config, lib, pkgs, ... }:

{
  networking.firewall.enable = true;
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = ["--ssh"];
  
}