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

      ../../users/alex.nix
      # ../../dev/git.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # networking.hostId = "d5abb711";
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

  # networking.hostName = "MzHyde"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";
     
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    helix
    neovim
    nmap
    nil
    binutils
    coreutils
    rustup
    go
    gopls
    pyenv
    rbenv
    nodenv
    toolbox
    podman
    nvidia-podman
    podman-desktop
    starship
    cowsay
    fortune
    btop
    tmux
    zellij
    pciutils
    resilio-sync
    obsidian
    qFlipper
    sunshine
    alacritty
    # cosmic-term
  ];
  # Freaking obsidian making me do this
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono"]; })
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
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
