{ config, lib, pkgs, ... }:
## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Syncthing
{
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
    services = {
        syncthing = {
            enable = true;
            openDefaultPorts = true;
            user = "alex";
            settings.options.urAccepted = -1;
            settings.options.relaysEnabled = false;
            settings.options.localAnnounceEnabled = false;
            configDir = "/home/alex/.config/syncthing";  
            settings.folders = {
                "Ravka" = {
                    path = "/home/alex/Ravka";
                };
                "Fold" = {
                    path = "/home/alex/Fold";
                };
                "Archives" = {
                    path = "/home/alex/Fold";
                };
            };
        };
    };
    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [22000 8384];
    networking.firewall.interfaces."tailscale0".allowedUDPPorts = [22000];
    networking.firewall.checkReversePath = "loose";
}
