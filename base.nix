{ pkgs, lib, config, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  users.users.freeman = {
    isNormalUser = true;
    description = "Jacob Freeman";
    extraGroups = [ "wheel" "networkmanager" "dialout" "plugdev" ];
  };

  users.defaultUserShell = pkgs.zsh;

  nix.settings.trusted-users = [ "jfreeman" ];

  services.autorandr.enable = true;

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = false;
  #services.xserver.excludePackages = [ xterm ];

  environment.shells = with pkgs; [ zsh ];

  environment.systemPackages = with pkgs; [
    alacritty
    git
    jq
    picocom
    fzf
    pavucontrol 
    mpv
    xclip
    chromium
    binutils
    pciutils
    usbutils
    htop
    wget
    tmux
    ack
    vscode
    gcc
    anki-bin
    zip
    unzip
    thunderbird
    ledger-live-desktop
    signal-desktop
    spotify
    mosh
  ];

  system.extraDependencies = [ pkgs.stdenv ];

  programs.zsh.enable = true;
  programs.neovim.enable = true;

  zramSwap.enable = true;

  # For use with rtl-sdr modules.
  services.udev.extraRules = ''
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", ENV{ID_SOFTWARE_RADIO}="1", MODE="0660", GROUP="plugdev"
  '';

  fonts.fonts = with pkgs; [
    inconsolata
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters =
    [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
}
