{ config, lib, pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf = {
        # enable = true;
        # packages = [(pkgs.OVMF.override {
          # secureBoot = true;
          # tpmSupport = true;
        # }).fd];
      # };
    };
  };
}
