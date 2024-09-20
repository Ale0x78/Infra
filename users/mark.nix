{ pkgs, home-manager, lib, catppuccin, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
  programs.fish.enable = true;
  catppuccin.enable = true;
  # home-manager.extraSpecialArgs = {
  #   inherit pkgs;
  # };
  home-manager.useGlobalPkgs = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mark.isNormalUser = true;
  users.users.mark = {
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
    {  users = [ "mark" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
  home-manager.users.mark = { pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };

};



    # nixpkgs.config = import ../os/nixos-pkgs.nix;
    home.stateVersion = "24.05";  
      home.packages = with pkgs; [
            vscode
            virt-manager
            lunar-client
            firefox
            discord
            gnome-bluetooth
            joycond
            krita
            brave
            openconnect
            steam
            gnome-tweaks
            htop
            capitaine-cursors
            gnomeExtensions.forge
            gnomeExtensions.logo-menu
            gnomeExtensions.vitals
            gnomeExtensions.space-bar
            gnomeExtensions.unite
            gnomeExtensions.top-bar-organizer
            google-chrome
            autossh
            git
            fish
            lutris
            zsh
            protonup-qt
            ryujinx
            neovide
            binutils
            coreutils
            virt-manager
            texliveFull
          ];
      programs.git = {
        enable = true;
        userName  = "Ale0x78";
        userEmail = "anahape@ncsu.edu";
      };
      programs.fish = {
        enable = true;
      };
  };
}
