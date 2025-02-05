{ config, lib, pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
     enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;

    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
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
