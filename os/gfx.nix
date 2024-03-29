{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;  
    displayManager.gdm = {
      enable = true;  
      wayland = true; 
    };
    desktopManager.gnome.enable = true; 
  };
  sound.enable = true;
  # Enable a bunch of other thinngs
  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
  };


}