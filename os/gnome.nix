{ pkgs, home-manager, lib, ... }:
let
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple;
in
{
    programs.dconf.enable = true;
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      desktopManager.gnome.extraGSettingsOverridePackages = [ pkgs.mutter ];
    };
    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];
    home-manager.users.alex = { pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };

  };
    dconf.settings = {
        "org/gnome/mutter" = {
          experimental-features = [ "scale-monitor-framebuffer" ];
        };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        color-scheme = "prefer-dark";
        icon-theme = "Adwaita";
        # All the below are installed at the system level
        # Could instead use `gtk.cursorTheme`, etc. and reference the actual packages
        cursor-theme = "capitaine-cursors";
        document-font-name = "Merriweather 11";
        font-name = "IBM Plex Sans Arabic 11";
        monospace-font-name = "FiraCode Nerd Font 10";
      };

      "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
          # forge.extensionUuid
          logo-menu.extensionUuid
          vitals.extensionUuid
          # pop-shell.extensionUuid
          # space-bar.extensionUuid
          # unite.extensionUuid
          # top-bar-organizer.extensionUuid
          caffeine.extensionUuid
      ];

      "com/raggesilver/BlackBox" = {
        style-preference = mkUint32 2;
        opacity = mkUint32 87;
        terminal-padding = mkTuple [(mkUint32 4) (mkUint32 4) (mkUint32 4) (mkUint32 4)];
        theme-dark = "Pencil Dark";
        use-sixel = true;
        floating-controls = true;
      };
    };

      home.packages = with pkgs.gnomeExtensions; [
        # forge
        logo-menu
        vitals
        # pop-shell
        # space-bar
        # unite
        # top-bar-organizer
        caffeine
      ];
  };
}
