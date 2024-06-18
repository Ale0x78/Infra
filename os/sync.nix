{ config, lib, pkgs, ... }:

## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Syncthing
{
    services = {
        syncthing = {
            enable = true;
            user = "alex";
            dataDir = "/home/alex";    # Default folder for new synced folders
            configDir = "/home/alex/.config/syncthing";   # Folder for Syncthing's settings and keys
        };
};
}
