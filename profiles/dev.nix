{ config, lib, pkgs, home-manager, vscode-server, ... }:
{

  services.ollama = {
  enable = true;
  host = "100.125.110.25";
  acceleration = "cuda";
  # models = "/archive/models";
  };
  services.vscode-server.enable = true;
  environment.systemPackages = with pkgs; [
      wget
      helix
      neovim
      slirp4netns
      gleam
      cmake
      gwe
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
