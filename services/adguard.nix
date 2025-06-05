{ config, lib, pkgs, ... }:
{
  services.adguardhome = {
    enable = true;
    port = 6969;
  };
  environment.systemPackages = with pkgs; [
    adguardian
  ];
}
