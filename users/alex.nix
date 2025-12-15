{ pkgs, home-manager, lib, ... }:
let
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple;
in
{
  programs.fish.enable = true;
  # vscode-insider = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
  #   src = (builtins.fetchTarball {
  #     url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
  #     sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  #   });
  #   version = "latest";

  #   buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
  # });
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex.isNormalUser = true;
  users.users.alex = {
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvphn6PPLViN5laYyU3VNH8FkAjRtZlKeXQENTQXqtJ anahape@ncsu.edu"];
    extraGroups = [
      "wheel"
      "networkmanager" # this is actually in the nixos documentation on networkmanager
      "video"
      "audio"
      "podman"
      "libvirtd"
      "dialout"
      "tty"
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
            lunar-client
            prismlauncher
            nexusmods-app
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
            ferium
            zellij
            pciutils
            qFlipper
            lutris
            protonup-qt
            virt-manager
            texliveFull
            nil
            vscode
            # vscode-insider
          ];
      programs.git = {
        enable = true;
        settings.user.name  = "Ale0x78";
        settings.user.email = "anahape@ncsu.edu";
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
