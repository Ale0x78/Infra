{ pkgs, home-manager,nixos-cosmic, lib, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
  services.xserver.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}
