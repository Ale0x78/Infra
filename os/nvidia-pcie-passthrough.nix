# 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA102 [GeForce RTX 3090] [10de:2204] (rev a1)
# 01:00.1 Audio device [0403]: NVIDIA Corporation GA102 High Definition Audio Controller [10de:1aef] (rev a1)

## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Nvidia
let
  # RTX 3070 Ti
  gpuIDs = [
    "10de:2204" # Graphics
    "10de:1aef" # Audio
  ];
in { pkgs, lib, config, ... }: {


  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";


  config = let cfg = config.vfio;
  in {
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 alex qemu-libvirtd -"
    ];
    # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;


    hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        # "nvidia"
        # "nvidia_modeset"
        # "nvidia_uvm"
        # "nvidia_drm"
      ];

      kernelParams = [
        # enable IOMMU
        "intel_iommu=on"
        "pcie_aspm=off"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

    hardware.opengl.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
