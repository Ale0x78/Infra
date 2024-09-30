{ pkgs, home-manager, lib, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
    services.xserver = {
      enable = true;
      displayManager.plasma6.enable = true;
      desktopManager.sddm.enable = true;
    };

}