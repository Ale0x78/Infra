{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      home-manager.nixosModules.home-manager
      ../../os/boot.nix
      ../../os/nixos-pkgs.nix
      ../../os/nvidia.nix
      ../../os/comms.nix
      ../../os/gfx.nix
      ../../os/school.nix
      ../../os/gaming.nix
      ../../users/gilly.nix
      ../../os/python3.nix
      ../../os/thebasics.nix
    ];

 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  fileSystems."/" =
    { device = "zpool/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zpool/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "zpool/var";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices = [ ];

  boot.zfs.extraPools = [ "zpool" ];
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";
  virtualisation.containers.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };


  security.pam.loginLimits = [

    { domain = "@kvm"; item = "memlock"; type = "-"   ; value = "unlimited"; }
    ];


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
