{ config, lib, pkgs, ... }:

{
programs.nix-ld.enable = true; # Needed for Heroic launcher 
  programs.nix-ld.libraries = with pkgs; [
  ];
  services.sunshine.enable = true;
  # programs.lutris.enable = true;
  environment.systemPackages = [
    pkgs.ferium
  ];
  hardware.steam-hardware.enable = true;
  services.sunshine.package = pkgs.sunshine.override {cudaSupport = true;};
  hardware.graphics.enable32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

}
