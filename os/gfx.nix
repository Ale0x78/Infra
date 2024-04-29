{ config, lib, pkgs, ... }:

{
  services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  sound.enable = true;
  programs.dconf.enable = true;
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
  # services.displayManager.sddm.wayland.enable = true;
  # Enable a bunch of other thinngs
  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
  };


}
