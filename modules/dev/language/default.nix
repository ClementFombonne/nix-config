{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  gccCfg = config.modules.language.gcc;
  pythonCfg = config.modules.language.python;
  typstCfg = config.modules.language.typst;
  rustCfg = config.modules.language.rust;
  javaCfg = config.modules.language.java;
  luaCfg = config.modules.language.lua;
  nixCfg = config.modules.language.nix;
in
{

  options.modules.language = {
    nix = {
      enable = mkEnableOption {
        description = "Enable the nix lsp and formatter.";
      };
    };

    gcc = {
      enable = mkEnableOption {
        description = "Enable the GNU Compiler Collection (gcc).";
      };
    };

    python = {
      enable = mkEnableOption {
        description = "Enable Python 3.12 and the UV package manager.";
      };
    };

    typst = {
      enable = mkEnableOption {
        description = ''
          Enable Typst, the modern markup‑based typesetting engine,
          together with its preview and LSP helpers.
        '';
      };
    };

    rust = {
      enable = mkEnableOption {
        description = ''
          Enable the Rust toolchain (compiler, Cargo, fmt, clippy,
          and rust‑analyzer).
        '';
      };
    };
    lua = {
      enable = mkEnableOption {
        description = "Enable lua support.";
      };
    };

    qt = {
      enable = mkEnableOption {
        description = ''
          Enable the qt toolchain.
        '';
      };
    };

    java = {
      enable = mkEnableOption {
        description = ''
          Enable the java toolchain.
        '';
      };
      package = mkOption {
        type = types.package;
        default = pkgs.jdk; # Usually points to the latest LTS (e.g., JDK 21)
        description = "The JDK package to use.";
      };
    };
  };

  config = mkMerge [
    # nix
    (mkIf nixCfg.enable {
      environment.systemPackages = with pkgs; [
        nixd
        nixfmt
      ];
    })
    # GCC
    (mkIf gccCfg.enable {
      environment.systemPackages = with pkgs; [
        gcc
        clang-tools
      ];
    })

    # Python (Python + uv)
    (mkIf pythonCfg.enable {
      environment.systemPackages = with pkgs; [
        uv
        python314
        ruff
        ty
      ];
    })

    # Typst (core + preview + formatter + LSP)
    (mkIf typstCfg.enable {
      environment.systemPackages = with pkgs; [
        typst
        tinymist
      ];
    })

    # Rust (compiler, Cargo, fmt, clippy, analyzer)
    (mkIf rustCfg.enable {
      environment.systemPackages = with pkgs; [
        cargo
        rust-analyzer
        rustfmt
        rustc
        clippy
      ];
    })

    # Lua
    (mkIf luaCfg.enable {
      environment.systemPackages = with pkgs; [
        lua-language-server
        stylua
      ];
    })

    # Qt (qt6 qml)
    (mkIf config.modules.language.qt.enable {
      environment.systemPackages = with pkgs; [
        kdePackages.qtdeclarative
      ];
    })
    # java
    (mkIf javaCfg.enable {
      # 1. Install the JDK and common build tools
      environment.systemPackages = with pkgs; [
        javaCfg.package
        maven
        gradle
      ];

      # 2. This is crucial for Java development on NixOS.
      # It sets JAVA_HOME and links the binaries to /usr/bin/java
      programs.java = {
        enable = true;
        package = javaCfg.package;
      };
    })
  ];
}
