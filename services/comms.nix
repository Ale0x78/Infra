{ config, lib, pkgs, ... }:
{
  networking.firewall.enable = true;
  services.tailscale.enable = true;
  services.tailscale.package = pkgs.tailscale;
  services.tailscale.extraUpFlags = ["--ssh"];
}