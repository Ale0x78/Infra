{ config, lib, pkgs, ... }:

{
programs.nix-ld.enable = true; # Needed for Heroic launcher 
  programs.nix-ld.libraries = with pkgs; [
  ];
  services.sunshine.enable = true;
  # programs.lutris.enable = true;
  
  hardware.steam-hardware.enable = true;
  services.sunshine.package = pkgs.sunshine.override {cudaSupport = true;};
}
