{ config, lib, pkgs, ... }:

{
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.mutter ];
  
  # Enable a bunch of other thinngs
  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    pulseaudio.enable = false;
    # pulseaudio.support32Bit = true;
  };

  programs.river.enable = true;


}
