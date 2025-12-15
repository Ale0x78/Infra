{ config, lib, pkgs, home-manager, ... }:
{

  # services.ollama = {
  # enable = true;
  # host = "100.125.110.25";
  # acceleration = "cuda";
  # models = "/archive/models";
  # };
  environment.systemPackages = with pkgs; [
      wget
      helix
      neovim
      slirp4netns
      gleam
      cmake
      gwe
      uv
      rustup
      go
      gopls
      just
      nvfancontrol
      distrobox
      nixd
      podman
      podman-desktop
      starship
      kitty
      tmux
    ];

}
