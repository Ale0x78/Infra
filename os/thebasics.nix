{ config, lib, pkgs, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      helix
      neovim
      nmap
      binutils
      coreutils
      gwe
      rustup
      go
      gopls
      pyenv
      tailscale
      rbenv
      usbutils
      nodenv
      nvfancontrol
      xwaylandvideobridge
      distrobox
      podman
      podman-desktop
      starship
      cowsay
      fortune
      btop
      binwalk
      tmux
      zellij
      pciutils
      resilio-sync
      obsidian
      qFlipper
      sunshine
      # cosmic-term
    ];
  fonts.packages = with pkgs; [
    noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono"]; })
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
  ];

}
