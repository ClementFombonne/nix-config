{ config, pkgs, inputs, ... }:

{
    # Boot options
    boot = {
        tmp.cleanOnBoot = true;
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        kernelModules = [ "i915" ];
        initrd.kernelModules = [ "i915" ];
    };
    console.keyMap = "fr";


    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];  
    nixpkgs.config.allowUnfree = true;
    services.xserver.desktopManager.xterm.enable = false;

    # base packages
    programs.zsh.enable = true;
    environment.systemPackages = with pkgs; [
        acpi vim git
    ];
    # Install fonts
    fonts = {
        packages = with pkgs; [
            jetbrains-mono
	        nerd-fonts.fira-code
            roboto
            openmoji-color
        ];
        fontconfig = {
            hinting.autohint = true;
            defaultFonts.emoji = [ "OpenMoji Color" ];
        };
    };


    # Wayland stuff: enable XDG integration, allow sway to use brillo
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
        };
    };

    # Nix settings, auto cleanup and enable flakes
    nix = {
        settings.auto-optimise-store = true;
        settings.allowed-users = [ "clement" ];
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 3d --min-free 5";
        };
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    # Set up locales (timezone and keyboard layout)
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
    };

    # Set up user and enable sudo
    users.users.clement = {
        isNormalUser = true;
        extraGroups = [ "input" "wheel" "networkmanager" ];
        shell = pkgs.zsh;
    };

    # Set up networking and secure it
    networking.networkmanager.enable = true;

    # Set environment variables
    environment.variables = {
        NIXOS_CONFIG = "$HOME/.config/nixos/modules/configuration.nix";
        NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
        XDG_DATA_HOME = "$HOME/.local/share";
        PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
        GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
        GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
        MOZ_ENABLE_WAYLAND = "1";
        ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
        EDITOR = "nvim";
        DIRENV_LOG_FORMAT = "";
        ANKI_WAYLAND = "1";
        DISABLE_QT5_COMPAT = "0";
    };

    # Security 
    security = {
        sudo.enable = true;
        doas = {
            enable = true;
            extraRules = [{
                users = [ "clement" ];
                keepEnv = true;
                persist = true;
            }];
        };

        # Extra security
        protectKernelImage = true;
    };


    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    services.blueman.enable = true;
    
    hardware = {
        bluetooth.enable = true;
	graphics.enable = true;
	graphics.extraPackages = with pkgs; [
	  mesa
	  libvdpau-va-gl
	  vaapiVdpau
	  intel-media-driver
	];
    };

    # Do not touch
    system.stateVersion = "25.05";
}
