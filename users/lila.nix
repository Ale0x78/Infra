{ pkgs, home-manager, lib, ... }:
let
mkUint32 = lib.gvariant.mkUint32;
mkTuple = lib.gvariant.mkTuple;
in
{
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lila.isNormalUser = true;
  users.users.lila = {
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
    {  users = [ "lila" ];
      commands = [
        { command = "ALL" ;
          options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];
  home-manager.users.lila = { pkgs, ...}: {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };

};

    # nixpkgs.config = import ../os/nixos-pkgs.nix;
    home.stateVersion = "24.05";
      home.packages = with pkgs; [
            virt-manager
            discord
            joycond
            krita
            openconnect
            steam
            capitaine-cursors
            git
            fish
            lutris
            zsh
            protonup-qt
          ];
      programs.git = {
        enable = true;
        settings.user = {
          name = "Lila";
          email = "lila@mithrun.local";
        };
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
