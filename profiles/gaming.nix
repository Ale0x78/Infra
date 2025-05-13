{ config, lib, pkgs, ... }:

{
  # services.sunshine.enable = true;
  environment.systemPackages = [
    pkgs.heroic
    pkgs.ryubing
    pkgs.ferium
    pkgs.sunshine
  ];
  hardware.steam-hardware.enable = true;
  # services.sunshine.
  hardware.graphics.enable32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    # package = pkgs.sunshine.override {cudaSupport = true;};
  };


}
