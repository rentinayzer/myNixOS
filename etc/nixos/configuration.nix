{
  config,
  lib,
  pkgs,
  inputs,
  ... 
}: {

  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.flatpak.enable = true;
  services.displayManager.ly.enable = true;
  services.upower.enable = true;

  users.users.maro = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      kitty
      hyprpaper
      git
      rofi
      thunar
      wl-clipboard
      neovim
      fastfetch
      quickshell
      matugen
      hypridle
      yazi
      obsidian
      prismlauncher
      cava
      chromium
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
  };
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";

}
