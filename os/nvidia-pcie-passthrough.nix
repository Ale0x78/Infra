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
      "f /dev/shm/scream 0660 alex qemu-libvirtd -"
    ];
    # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "kvm-intel"
      ];

      kernelParams = [
        "intel_iommu=on"
        "kvm.ignore_msrs=1"
        "kvm.report_ignored_msrs=0"
        "pcie_aspm=off"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

    hardware.opengl.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
