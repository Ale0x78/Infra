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

    nixpkgs.overlays = [
      # GNOME 46: triple-buffering-v4-46
      (final: prev: {
        gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
          mutter = gnomePrev.mutter.overrideAttrs (old: {
            src = pkgs.fetchFromGitLab  {
              domain = "gitlab.gnome.org";
              owner = "vanvugt";
              repo = "mutter";
              rev = "triple-buffering-v4-46";
              hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
            };
          });
        });
      })
    ];
    nixpkgs.config.allowAliases = false;

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
          forge.extensionUuid
          logo-menu.extensionUuid
          vitals.extensionUuid
          space-bar.extensionUuid
          unite.extensionUuid
          top-bar-organizer.extensionUuid
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
        # logo-menu
        # vitals
        # space-bar
        # unite
        # top-bar-organizer
        caffeine
      ];
  };
}