{ config, lib, pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    adguardian
  ];
    networking.firewall.interfaces."enp3s0".allowedTCPPorts = [53 80 5353];
    networking.firewall.interfaces."enp3s0".allowedUDPPorts = [53 5353];
 
}
