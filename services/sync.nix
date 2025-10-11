{ config, lib, pkgs, ... }:
## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Syncthing
{
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
    services = {
        syncthing = {
            settings.devices = {
                "marcille" = {id = "Q43KN23-H6WC3PK-TAO3XGH-27DB73J-F6GGDH2-FL4AQGM-LPLKLP6-VPIIAA7"; }; 
            };
            enable = true;
            openDefaultPorts = true;
            user = "alex";
            settings.options.urAccepted = -1;
            settings.options.relaysEnabled = false;
            settings.options.localAnnounceEnabled = false;
            configDir = "/home/alex/.config/syncthing";  
            settings.folders = {
                "Ravka" = {
                    path = "/home/alex/archive/Ravka";
                    devices = [ "marcille" ];
                };
                "Ambrosia" = {
                    path = "/home/alex/Ambrosia";
                    devices = [ "marcille" ];
                };
            };
        };
    };
    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [22000 8384];
    networking.firewall.interfaces."tailscale0".allowedUDPPorts = [22000];
    networking.firewall.checkReversePath = "loose";
}
