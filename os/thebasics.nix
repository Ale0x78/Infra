{ config, lib, pkgs, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
      wget
      helix
      neovim
      nmap
      binutils
      coreutils
      gleam
      apfs-fuse
      cmake
      gwe
      rustup
      wl-clipboard
      go
      gopls
      pyenv
      tailscale
      rbenv
      usbutils
      signal-desktop-bin
      nodenv
      nvfancontrol
      # xwaylandvideobridge
      distrobox
      podman
      podman-desktop
      starship
      kitty
      cowsay
      fortune
      btop
      binwalk
      tmux
      firefox
      sunshine
      # cosmic-term
    ];
  fonts.packages = with pkgs; [
    noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji
    liberation_ttf
    fira-code
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
  ];

}
