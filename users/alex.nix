{ pkgs, home-manager, lib, catppuccin, ... }:
let 
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple; 
in 
{
  programs.fish.enable = true;
  # catppuccin.enable = true;
  # gtk.catppuccin.enable = true;
  # gtk.catppuccin.gnomeShellTheme = true;
  # home-manager.extraSpecialArgs = {
  #   inherit pkgs;
  # };
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
    imports = [catppuccin.homeManagerModules.catppuccin];
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
            sshuttle
            looking-glass-client
            virt-manager
            lunar-client
            firefox
            discord
            gnome-bluetooth
            joycond
            telegram-desktop
            krita
            brave
            openconnect
            steam
            gnome-tweaks
            slack
            htop
            ladybird
            capitaine-cursors
            google-chrome
            autossh
            git
            fish
            lutris
            zsh
            protonup-qt
            ryujinx
            jetbrains.datagrip
            jetbrains.dataspell
            neovide
            jetbrains.idea-ultimate
            jetbrains.goland
            jetbrains.datagrip
            jetbrains.dataspell
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
