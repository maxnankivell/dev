# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # ----------------
  # Core Settings
  # ----------------

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "maxnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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

  # Nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;  # see the note above

  # Keyboard layout
  # Note: KDE Plasma overrides this setting
  services.xserver.xkb = {
    layout = "us,us";
    variant = ",dvorak";
    options = "grp:win_space_toggle";
  };
  # For Kanata overrides
  hardware.uinput.enable = true;

  # ----------------
  # User settings
  # ----------------

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  user packages (almost never use this)
    ];
    useDefaultShell = true;
  };

  # ----------------
  # Services
  # ----------------

  # Kanata for keyboard customization
  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defsrc
        caps a s d f  w
      )

      (defalias
        cap (tap-hold 150 150 esc (layer-while-held edit))
      )

      (deflayer base
        @cap a s d f  w
      )

      (deflayer edit
        _ C-/ C-b C-i C-. (layer-while-held terminal-sublayer)
      )

      (deflayer terminal-sublayer
        _ _ _ C-S-i C-S-. _
      )
    '';
  };

  # ----------------
  # Programs
  # ----------------

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "docker-compose"
        "terraform"
        "aws"
      ];
    };

    shellAliases = {
      cat = "bat";
      ls = "eza -a --icons=auto";
      cd = "z";
      cdi = "zi";
      rebuild = "sudo nixos-rebuild switch";
    };

    promptInit = ''
      fastfetch
    '';

    loginShellInit = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML ''
      "$schema" = 'https://starship.rs/config-schema.json'

      format = """
      $os\
      $username\
      $directory\
      $git_branch\
      $git_status\
      $c\
      $rust\
      $golang\
      $nodejs\
      $php\
      $java\
      $kotlin\
      $haskell\
      $python\
      $docker_context\
      $conda\
      $time\
      $cmd_duration\
      $line_break\
      $character"""

      [os]
      disabled = false
      format = '[$symbol ]($style)'
      style = "fg:red"

      [os.symbols]
      Windows = ""
      Ubuntu = "󰕈"
      SUSE = ""
      Raspbian = "󰐿"
      Mint = "󰣭"
      Macos = "󰀵"
      Manjaro = ""
      Linux = "󰌽"
      NixOS = ""
      Gentoo = "󰣨"
      Fedora = "󰣛"
      Alpine = ""
      Amazon = ""
      Android = ""
      AOSC = ""
      Arch = "󰣇"
      Artix = "󰣇"
      CentOS = ""
      Debian = "󰣚"
      Redhat = "󱄛"
      RedHatEnterprise = "󱄛"

      [username]
      show_always = true
      style_user = "fg:red bold"
      style_root = "fg:red bold"
      format = '[$user ]($style)'

      [directory]
      style = "fg:blue bold"
      format = "[$path ]($style)"
      truncation_length = 3
      truncation_symbol = "…/"

      [directory.substitutions]
      "Documents" = "󰈙 "
      "Downloads" = " "
      "Music" = "󰝚 "
      "Pictures" = " "
      "Developer" = "󰲋 "

      [git_branch]
      symbol = ""
      style = "fg:yellow"
      format = '[$symbol $branch ]($style)'

      [git_status]
      style = "fg:yellow"
      format = '[($all_status$ahead_behind )]($style)'

      [nodejs]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [c]
      symbol = " "
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [rust]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [golang]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [php]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [java]
      symbol = " "
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [kotlin]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [haskell]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version) ]($style)'

      [python]
      symbol = ""
      style = "fg:green"
      format = '[$symbol ($version)(\(#$virtualenv\)) ]($style)'

      [docker_context]
      symbol = ""
      style = "fg:cyan"
      format = '[$symbol ($context) ]($style)'

      [conda]
      symbol = "  "
      style = "fg:cyan"
      format = '[$symbol $environment ]($style)'
      ignore_base = false

      [time]
      disabled = false
      time_format = "%R"
      style = "fg:purple"
      format = '[ $time ]($style)'

      [character]
      disabled = false
      success_symbol = '[❯](bold fg:green)'
      error_symbol = '[❯](bold fg:red)'
      vimcmd_symbol = '[❮](bold fg:green)'
      vimcmd_replace_one_symbol = '[❮](bold fg:purple)'
      vimcmd_replace_symbol = '[❮](bold fg:purple)'
      vimcmd_visual_symbol = '[❮](bold fg:yellow)'

      [cmd_duration]
      show_milliseconds = true
      format = "[ in $duration ]($style)"
      style = "fg:purple"
      disabled = false
      show_notifications = true
      min_time_to_notify = 45000

      [line_break]
      disabled = false
    '';
  };

  # Zoxide
  programs.zoxide.enable = true;

  # Direnv
  programs.direnv.enable = true;

  # Firefox
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4733069/multi_account_containers-8.3.7.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  # Steam
  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Fonts
    fira-code
    # CLI Tools
    git
    bat
    eza
    fzf
    fastfetch
    tmux
    claude-code
    p7zip
    spotify-player
    btop
    # Apps
    ghostty
    vesktop
    cinny-desktop
    vscode
    spotify
    heroic
    prusa-slicer
    notion-app-enhanced
    bruno
  ];

  # ----------------
  # Other
  # ----------------

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
  system.stateVersion = "25.11"; # Did you read the comment?

}
