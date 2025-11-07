{ pkgs, home-manager, lib, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
  services.xserver.enable = true;
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";

  services = {
    displayManager.sddm = {
      enable = true;
      # package = pkgs.kdePackages.sddm; # our module/the upstream port requires the qt6 version
    };
  };

  environment.systemPackages = with pkgs; [
    #  libsForQt5.bismuth
     catppuccin-kde
  ];
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;


  qt = {
    enable = true;
  };
}
