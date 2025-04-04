{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      home-manager.nixosModules.home-manager
      ../../os/boot.nix
      ../../os/nixos-pkgs.nix
      ../../os/nvidia.nix
      ../../os/nvidia-pcie-passthrough.nix
      ../../os/comms.nix
      ../../os/gfx.nix
      # ../../os/kde.nix
      ../../os/gnome.nix
      # ../../os/cosmic.nix
      ../../os/school.nix
      ../../os/gaming.nix
      ../../users/alex.nix
      ../../os/sync.nix
      ../../os/python3.nix
      ../../os/thebasics.nix
      ../../os/localSSH.nix
      ../../os/virtual.nix
      # ../../os/hacking.nix
    ];


  specialisation."VFIO".configuration = {
   system.nixos.tags = [ "with-vfio" ];
   vfio.enable = true;
  };
  # nix.settings.system-features = map (x: "gccarch-${x}") ((lib.systems.architectures.inferiors.alderlake or []) ++ ["alderlake"]);
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # nixpkgs.hostPlatform = {
  #     gcc.arch = "alderlake";
  #     gcc.tune = "alderlake";
  #     system = "x86_64-linux";
  # };
  
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  fileSystems."/" =
    { device = "zpool/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/nix" =
    { device = "zpool/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/var" =
    { device = "zpool/var";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];
  zramSwap.enable = true;

  boot.zfs.devNodes = "/dev/disk/by-id/ata-TOSHIBA_HDWG780UZSVA_94G0A1QRFWAJ-part1";

  boot.zfs.extraPools = [ "zpool" ];
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Disable the motherboards's builtin bluetooth
  # Thanks https://discourse.nixos.org/t/how-to-disable-the-bluetooth-of-my-intel-wifi-card/40407/4
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="13d3", ATTR{idProduct}=="3533", ATTR{busnum}=="1", ATTR{authorized}="0"
    '';
    # SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0a2a",

  # networking.hostName = "MzHyde"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";




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
