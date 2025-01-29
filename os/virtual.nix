{ config, lib, pkgs, ... }:

{
  virtualisation.containers.enable = true;
  # virtualisation.lxd = {
    # enable = true;
    # recommendedSysctlSettings = true;
    # lxcPackage = pkgs.lxc;
  # };

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
}
