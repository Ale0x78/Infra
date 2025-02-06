{ pkgs, home-manager, lib, ... }:
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



    # nixpkgs.config = import ../os/nixos-pkgs.nix;
    home.stateVersion = "24.05";
      home.packages = with pkgs; [
            zed-editor
            ferium
            nixd
            docker-compose
            podman-compose
            virt-manager
            lunar-client
            prismlauncher
            nexusmods-app
            firefox
            discord
            joycond
            starship
            telegram-desktop
            krita
            openconnect
            steam
            htop
            capitaine-cursors
            autossh
            git
            fish
            lutris
            zsh
            protonup-qt
            ryujinx
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

  programs.git = {
          config = {
            init = {
              defaultBranch = "main";
              pull.rebase = false; # Merge!
            };
          };
  };

}
