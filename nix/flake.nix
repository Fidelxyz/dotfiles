{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          # GNU programs non-existing in macOS
          pkgs.watch
          pkgs.wget
          pkgs.wdiff

          # GNU programs whose BSD counterpart is installed in macOS
          pkgs.coreutils
          pkgs.binutils
          pkgs.diffutils
          pkgs.ed
          pkgs.findutils
          pkgs.gawk
          pkgs.indent
          pkgs.gnused
          pkgs.gnutar
          pkgs.which
          pkgs.gnugrep
          pkgs.gzip
          pkgs.screen

          # GNU programs existing in macOS which are outdated
          pkgs.bash
          pkgs.patch
          pkgs.less
          pkgs.m4
          pkgs.gnumake
          pkgs.nano
          pkgs.bison

          # BSD programs existing in macOS which are outdated
          pkgs.flex

          # Other common/preferred programs in GNU/Linux distributions
          pkgs.libressl
          pkgs.file
          pkgs.openssh
          pkgs.perl
          pkgs.rsync
          pkgs.zip
          pkgs.unzip
          pkgs.vim

          # Essentials
          pkgs.neovim
          pkgs.tmux
          pkgs.fd
          pkgs.ripgrep
          pkgs.fzf
          pkgs.zoxide
          pkgs.direnv
          pkgs.stow
          pkgs.tlrc
          pkgs.dua

          # Version Control Systems
          pkgs.git
          pkgs.git-filter-repo
          pkgs.lazygit
          pkgs.jujutsu
          pkgs.lazyjj

          # Python
          pkgs.python3
          pkgs.uv

          # Node.js
          pkgs.nodejs_22
          pkgs.pnpm

          # Rust
          pkgs.rustup

          # Media Processing
          pkgs.ffmpeg
          pkgs.gpac
          pkgs.yt-dlp

          pkgs.gh
          pkgs.opencode

          # Casks
          pkgs.qbittorrent
        ];

      fonts.packages = [
        pkgs.caladea
        pkgs.inter
        pkgs.maple-mono.NF-CN
        pkgs.nerd-fonts.caskaydia-mono
        pkgs.nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;
        enableZshIntegration = true;

        onActivation.autoUpdate = true;
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;

        casks = [
          # Development
          "imhex"
          "termius"
          "utm"
          "visual-studio-code"
          "wezterm"

          # Browsers
          "firefox"
          "ungoogled-chromium"

          # Utilities
          "alienator88-sentinel"
          "jordanbaird-ice"
          "karabiner-elements"
          "keka"
          "linearmouse"
          "snipaste"

          # Fonts
          "font-unbounded"
          "font-cal-sans"
          "font-satoshi"

          "1password"
          "aegisub"
          "altserver"
          "basictex"
          "blender@lts"
          "calibre"
          "chatgpt"
          "feishu"
          "handbrake-app"
          "iina"
          "lm-studio"
          "mark-text"
          "notion"
          "obs"
          "pearcleaner"
          "playcover-community"
          "shutter-encoder"
          "squirrel-app"
          "tencent-meeting"
          "tuxera-ntfs"
        ];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.primaryUser = "fidel";

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        dock.tilesize = 56;
        dock.largesize = 16;
        finder.FXPreferredViewStyle = "clmv";
      };
      security.pam.services.sudo_local.touchIdAuth = true;

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = [ "/Applications" ];
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Fidels-MacBook-Pro
    darwinConfigurations."Fidels-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "fidel";
          };
        }
      ];
    };
  };
}
