{ config, lib, pkgs, upkgs, home-manager, ... }:
let 
  mkUint32 = lib.gvariant.mkUint32;
  mkTuple = lib.gvariant.mkTuple; 
in 
{
  programs.fish.enable = true;
  home-manager.useGlobalPkgs = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex.isNormalUser = true;
  users.users.alex = {
    shell = pkgs.fish;
    extraGroups = [   
      "wheel"
      "networkmanager" # this is actually in the nixos documentation on networkmanager
      "video"
      "audio"
      "libvirtd"
    ];

  };
    security.sudo.extraRules= [
    {  users = [ "alex" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
  home-manager.users.alex = { pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };

};


    dconf.settings = {
        # "org/gnome/desktop/interface".color-scheme = "prefer-dark";
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

      "com/raggesilver/BlackBox" = {
        style-preference = mkUint32 2;
        opacity = mkUint32 87;
        terminal-padding = mkTuple [(mkUint32 4) (mkUint32 4) (mkUint32 4) (mkUint32 4)];
        theme-dark = "Pencil Dark";
        use-sixel = true;
        floating-controls = true;
      };
    };
    # nixpkgs.config = import ../os/nixos-pkgs.nix;
    home.stateVersion = "23.11";  
      home.packages = with pkgs; [
            vscode
            firefox
            brave
            discord
            telegram-desktop
            steam
            slack
            htop
            capitaine-cursors
            git
            fish
            zsh
            tailscale
            protonup-qt
            ryujinx
            jetbrains.datagrip
            jetbrains.dataspell
            neovide
            jetbrains-toolbox
            virt-manager
            ticktick
            beeper
            texliveFull
          ];
      programs.git = {
        enable = true;
        userName  = "Ale0x78";
        userEmail = "anahape@ncsu.edu";
        extraConfig = {
          safe.directory = ["/etc/nixos"];
        };
      };
      programs.fish = {
        enable = true;
      };
  };
}
