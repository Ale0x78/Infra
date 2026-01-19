{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    home-manager.nixosModules.home-manager
    ../../profiles/nixos-pkgs.nix
    ../../profiles/gfx.nix
    ../../profiles/school.nix
    ../../profiles/gaming.nix
    ../../profiles/thebasics.nix
    ../../profiles/virtual.nix
    ../../profiles/dev.nix
    ../../profiles/web.nix
    # ../../profiles/gamedev.nix

    ../../users/alex.nix
    ../../users/lila.nix

    ../../services/boot.nix
    ../../services/nvidia.nix
    ../../services/nvidia-pcie-passthrough.nix
    ../../services/comms.nix
    ../../services/kde.nix
    ../../services/sync.nix
    ../../services/python3.nix
  ];
  networking.hostId = "d5abb711";
  specialisation."VFIO".configuration = {
    system.nixos.tags = [ "with-vfio" ];
    vfio.enable = true;
  };
  # nix.settings.system-features = map (x: "gccarch-${x}") ((lib.systems.architectures.inferiors.alderlake or []) ++ ["alderlake"]);
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs.hostPlatform = {
  #     gcc.arch = "alderlake";
  #     gcc.tune = "alderlake";
  #     system = "x86_64-linux";
  # };

  # # Create datasets
  # zfs create zpool/root
  # zfs create zpool/nix
  # zfs create zpool/var
  # zfs create zpool/home
  # # zfs create spool/archive

  # # Mount root
  # mkdir -p /mnt
  # mount -t zfs zpool/root /mnt -o zfsutil

  # # Mount nix, var, home
  # mkdir /mnt/nix /mnt/var /mnt/home
  # mount -t zfs zpool/nix /mnt/nix -o zfsutil
  # mount -t zfs zpool/var /mnt/var -o zfsutil
  # mount -t zfs zpool/home /mnt/home -o zfsutil

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  fileSystems."/" = {
    device = "zpool/root";
    fsType = "zfs";
    options = [
      "zfsutil"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "zpool/nix";
    fsType = "zfs";
    options = [
      "zfsutil"
      "noatime"
    ];
  };

  fileSystems."/var" = {
    device = "zpool/var";
    fsType = "zfs";
    options = [
      "zfsutil"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "zpool/home";
    fsType = "zfs";
    options = [
      "zfsutil"
      "noatime"
    ];
  };

  fileSystems."/archive" = {
    device = "spool/archive";
    fsType = "zfs";
    options = [
      "zfsutil"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  boot.zfs.pools.spool.devNodes = "/dev/disk/by-id/ata-TOSHIBA_HDWG780UZSVA_94G0A1QRFWAJ-part1"; # Archive data

  boot.zfs.pools.zpool.devNodes = "/dev/disk/by-id/nvme-WD_BLACK_SN770_1TB_22405U800412_1-part2"; # Host OS
  boot.kernelParams = [ "zfs.zfs_arc_max=3221225472" ]; # 3GB

  boot.zfs.extraPools = [
    "zpool"
    "spool"
  ];
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
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";
  security.pam.loginLimits = [

    {
      domain = "@kvm";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
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
