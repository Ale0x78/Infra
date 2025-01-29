{ config, lib, pkgs, ... }:



## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Syncthing
{
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
    services = {
        syncthing = {
            enable = true;
            user = "alex";
            settings.options.urAccepted = -1;
            settings.options.relaysEnabled = false;
            settings.options.localAnnounceEnabled = false;
            dataDir = "/home/alex/Sync";    # Default folder for new synced folders
            configDir = "/home/alex/.config/syncthing";   # Folder for Syncthing's settings and keys
            folders = {
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
}
