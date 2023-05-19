# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ 
			# Include the results of the hardware scan.
			./hardware-configuration.nix
			./modules/asusctl.nix
		];

	services.asusctl.enable = true;

	nix = {
		settings.experimental-features = [ "nix-command" "flakes" ];
	};

	# Fonts
	fonts = {
		enableDefaultFonts = true;
 
		fonts = with pkgs; [ 
			noto-fonts
			noto-fonts-cjk
			twitter-color-emoji
			ubuntu_font_family
			unifont
			(nerdfonts.override { fonts = [ "FiraCode" ]; })
		];

		fontconfig = {
			antialias = true;
			defaultFonts = {
				serif = [ "Ubuntu" "Noto Serif" "Noto Serif Japanese"];
				sansSerif = [ "Ubuntu" "Noto Sans" "Noto Sans Japanese" ];
				monospace = [ "Ubuntu Source" "Noto Sans Mono" ];
				emoji = [ "Twitter Color Emoji" ];
			};
		};
	};

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";
	boot.supportedFilesystems = [ "ntfs" ];

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Asia/Tokyo";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_PT.UTF-8";
		LC_IDENTIFICATION = "pt_PT.UTF-8";
		LC_MEASUREMENT = "pt_PT.UTF-8";
		LC_MONETARY = "pt_PT.UTF-8";
		LC_NAME = "pt_PT.UTF-8";
		LC_NUMERIC = "pt_PT.UTF-8";
		LC_PAPER = "pt_PT.UTF-8";
		LC_TELEPHONE = "pt_PT.UTF-8";
		LC_TIME = "pt_PT.UTF-8";
	};

	i18n.inputMethod.enabled = "ibus";
	i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc ];

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the GNOME Desktop Environment.
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	# Configure keymap in X11
	services.xserver = {
		layout = "pt";
		xkbVariant = "";
	};

	# Configure console keymap
	console.keyMap = "pt-latin1";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
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

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.eduardo = {
		isNormalUser = true;
		description = "Eduardo Correia";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		#  thunderbird
		];
	};

	# Enable automatic login for the user.
	services.xserver.displayManager.autoLogin.enable = true;
	services.xserver.displayManager.autoLogin.user = "eduardo";

	# Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
	systemd.services."getty@tty1".enable = false;
	systemd.services."autovt@tty1".enable = false;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	environment.systemPackages = with pkgs; [
		google-chrome
		# Wayland clipboard utilities. Needed for NeoVim system clipboard support
		wl-clipboard
	];

	programs.zsh.enable = true;
	users.users.eduardo.shell = pkgs.zsh;

	programs = {
		steam = {
				enable = true;
				remotePlay.openFirewall = true;      # Open ports in the firewall for Steam Remote Play
				dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		};
	};
	
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# Nvidia drivers
	services.xserver.videoDrivers = [ "nvidia" ];

	hardware.opengl.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

	services.flatpak.enable = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "22.11"; # Did you read the comment?
}
