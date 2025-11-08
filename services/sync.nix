{ config, lib, pkgs, ... }:
## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Syncthing
{
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
    services = {
        syncthing = {
            settings.devices = {
                "marcille" = {id = "REP2D47-NXPFV4N-HNVA3SY-OIERINY-7ITD4BX-YCHOSFK-Y2HX7SD-6I5MPQ4"; }; 
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
                    path = "/archive/Ravka";
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
