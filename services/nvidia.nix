{ config, lib, pkgs, ... }:

## This is directly from the NixOS wiki
# https://nixos.wiki/wiki/Nvidia
{
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;
    prime = {
        sync.enable = true;
        # offload.enable = true;
        # offload.enableOffloadCmd = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.sessionVariables = rec {
    CLUTTER_PAINT = "disable-clipped-redraws:disable-culling";
    CLUTTER_VBLANK = "true";
  };



  # Direct Rendering Infrastructure (DRI) support, both for 32-bit and 64-bit, and
  # Make sure opengl is enabled
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # Install additional packages that improve graphics performance and compatibility.
      extraPackages = with pkgs; [

        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        vulkan-validation-layers

      ];
    };
  };


  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [

    clinfo
    virtualglLib
    vulkan-loader
    vulkan-tools
    nvfancontrol

  ];
}
