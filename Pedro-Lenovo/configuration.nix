# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Pedro-Lenovo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Waydoird
  virtualisation.waydroid.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
	  General = {
	  	Experimental = true;
  	};
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable screen broadcasts
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    pkgs.kdePackages.kate
    #  pkgs.thunderbird
    pkgs.vscode
    pkgs.github-desktop
    pkgs.spotify
    pkgs.conda
    pkgs.discord
    pkgs.whatsapp-for-linux
    pkgs.brave
    pkgs.python3
    pkgs.julia
    pkgs.fortran-language-server
    pkgs.texliveFull
    pkgs.pandoc
    pkgs.yt-dlp
    pkgs.ffmpeg-full
    pkgs.mangal
    pkgs.ruby
    pkgs.calibre
    # pkgs.bisq-desktop # Broken, bisq2 existe
    pkgs.multimarkdown


    # Minecraft install
    (pkgs.prismlauncher.overrideAttrs(oldAttrs: rec {
      src = pkgs.fetchFromGitHub {
      owner = "Diegiwg";
      repo = "PrismLauncher-Cracked";
      rev = "99aeed1f092d5dd3df1f48174f1b4a1df3f6ecac";
      hash = "sha256-rqDnaXz9hUDugIzHVG+5xbBPOTm8FAWFyPIDOmNgQ0Q=";
      };}))
  ];


  # Install firefox.
  programs.firefox.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

    # Run normal binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = (with pkgs; [
    libva # fuck alvr, they removed the appimages
    ocamlPackages.alsa
    alsa-lib
    xfce.libxfce4windowing
    xfce.xfwm4
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    brotli
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    ffmpeg
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    libvdpau
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    pulseaudio
    systemd
    vulkan-loader
    wayland
    x264
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
    libplist
  ]);

  # Zsh
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestions.enable = true;
     syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "bureau";
    };
  };

  # Git
  programs.git.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Flakes
  nix = {
    # Adicionar flake inputs no registry
    registry = builtins.mapAttrs (_name: value: {flake = value;}) inputs;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = "-d --delete-older-than 30d";
    };
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pedro = {
    isNormalUser = true;
    description = "Pedro";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
