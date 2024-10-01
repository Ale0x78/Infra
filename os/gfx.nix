{ config, lib, pkgs, ... }:

{
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.mutter ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  
  # Enable a bunch of other thinngs
  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    pulseaudio.enable = false;
    # pulseaudio.support32Bit = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk
  #     xdg-desktop-portal-gnome
  #   ];
  };



}
