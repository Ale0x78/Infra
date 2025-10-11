{ config, lib, pkgs, home-manager, ... }:
{

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    models = "/home/alex/archive/models";
  };
  environment.systemPackages = with pkgs; [
      wget
      helix
      neovim
      gleam
      cmake
      gwe
      rustup
      go
      gopls
      signal-desktop-bin
      nodenv
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
