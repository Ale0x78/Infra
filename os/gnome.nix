{ pkgs, home-manager, lib, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
    home-manager.users.alex = { pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };

  };
    dconf.settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        "org/gnome/mutter" = {
          experimental-features = [ "scale-monitor-framebuffer" ];
        };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        # All the below are installed at the system level
        # Could instead use `gtk.cursorTheme`, etc. and reference the actual packages
        cursor-theme = "capitaine-cursors";
        document-font-name = "Merriweather 11";
        font-name = "IBM Plex Sans Arabic 11";
        monospace-font-name = "FiraCode Nerd Font 10";
      };

      "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
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

  };
}