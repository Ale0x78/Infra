{ config, lib, pkgs, ... }:

{
  # Enable a bunch of other thinngs
  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    # pulseaudio.enable = false;
    # pulseaudio.support32Bit = true;
  };

  programs.river.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
      wl-clipboard
      signal-desktop-bin
    ];

}
