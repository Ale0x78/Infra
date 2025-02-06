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
      gleam
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
      signal-desktop
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
      ferium
      zellij
      pciutils
      qFlipper
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
