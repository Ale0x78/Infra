{ config, lib, pkgs, home-manager, ... }:

{
  programs.fish.enable = true;

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