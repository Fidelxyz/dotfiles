{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-omlx = {
      url = "github:jundot/omlx";
      flake = false;
    };
    homebrew-open-tap-casks = {
      url = "github:open-tap/homebrew-casks";
      flake = false;
    };
    homebrew-magpie-releases = {
      url = "github:yetone/magpie-releases";
      flake = false;
    };
  };

  outputs = inputs@{
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    homebrew-omlx,
    homebrew-open-tap-casks,
    homebrew-magpie-releases,
  }:
  let
    configuration = { pkgs, config, ... }: {
      # NixOS/nixpkgs#582675: per-platform node_modules hash for opencode.
      nixpkgs.overlays = [
        (final: prev: {
          opencode = prev.opencode.overrideAttrs (old: {
            node_modules = old.node_modules.overrideAttrs (_: {
              outputHash =
                if final.stdenv.hostPlatform.isDarwin then
                  "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc="
                else
                  "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
            });
          });
        })
      ];

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      # Expose libiconv to Rust and C linkers outside a Nix development shell.
      environment.variables = {
        LIBRARY_PATH = "${pkgs.libiconv}/lib";
        PKG_CONFIG_PATH = "${pkgs.ffmpeg.dev}/lib/pkgconfig";
        LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      };

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
          pkgs.ast-grep
          pkgs.fzf
          pkgs.zoxide
          pkgs.direnv
          pkgs.stow
          pkgs.tlrc
          pkgs.dua
          pkgs.wezterm.terminfo

          # Development
          pkgs.tree-sitter
          pkgs.docker
          pkgs.libiconv
          pkgs.pkg-config

          # Version Control Systems
          pkgs.git
          pkgs.git-filter-repo
          pkgs.lazygit
          pkgs.jujutsu
          pkgs.lazyjj

          # Python
          pkgs.python3
          pkgs.uv
          pkgs.ruff
          pkgs.basedpyright

          # Node.js
          pkgs.nodejs_22
          pkgs.pnpm
          pkgs.prettier

          # Rust
          pkgs.rustup

          # C / C++
          pkgs.clang
          pkgs.clang-tools
          pkgs.llvmPackages.libclang.lib
          pkgs.llvmPackages.llvm # dsymutil used by clang on macOS

          # Lua
          pkgs.lua
          pkgs.luarocks
          pkgs.lua-language-server
          pkgs.stylua

          # YAML
          pkgs.yamlfmt

          # Shell
          pkgs.shellcheck

          # Media Processing
          pkgs.ffmpeg
          pkgs.ffmpeg.dev
          pkgs.gpac
          pkgs.yt-dlp
          pkgs.czkawka

          pkgs.gh
          pkgs.opencode
          pkgs.codex
          pkgs.ccusage
          pkgs.xdg-ninja
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

        onActivation.autoUpdate = false;
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;
        onActivation.extraFlags = [ "--verbose" ];

        taps = map (name: { inherit name; trusted = true; })
          (builtins.attrNames config.nix-homebrew.taps);

        brews = [
          "jundot/omlx/omlx"
        ];

        casks = [
          # Development
          "chatgpt"
          "imhex"
          "magpie-app"
          "orbstack"
          "openchamber"
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
          "lulu"
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
          "feishu"
          "handbrake-app"
          "iina"
          "notion"
          "obs"
          "pearcleaner"
          "shutter-encoder"
          "squirrel-app"
          "tencent-meeting"
          "tuxera-ntfs"

          "open-tap/casks/qbittorrent"
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

      nix.optimise = {
        automatic = true;
        interval = {
          Hour = 3;
          Minute = 0;
        };
      };
      nix.gc = {
        automatic = true;
        interval = {
          Hour = 3;
          Minute = 0;
        };
        options = "--delete-older-than 7d";
      };

      system.primaryUser = "fidel";

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        dock.tilesize = 56;
        dock.largesize = 16;
        finder.FXPreferredViewStyle = "clmv";
      };
      security.pam.services.sudo_local.touchIdAuth = true;
      security.pki.caCertificateBlacklist = [
        "Comodo AAA Services root"
      ];

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
            mutableTaps = false;

            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "jundot/homebrew-omlx" = homebrew-omlx;
              "open-tap/homebrew-casks" = homebrew-open-tap-casks;
              "yetone/homebrew-magpie-releases" = homebrew-magpie-releases;
            };
          };
        }
      ];
    };
  };
}
