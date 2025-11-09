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
in
{

  options.modules.language = {
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
  };

  config = mkMerge [
    # GCC
    (mkIf gccCfg.enable {
      environment.systemPackages = with pkgs; [ gcc ];
    })

    # Python (Python + uv)
    (mkIf pythonCfg.enable {
      environment.systemPackages = with pkgs; [
        uv
        python314
      ];
    })

    # Typst (core + preview + formatter + LSP)
    (mkIf typstCfg.enable {
      environment.systemPackages = with pkgs; [
        typst
        typstyle
      ];
    })

    # Rust (compiler, Cargo, fmt, clippy, analyzer)
    (mkIf rustCfg.enable {
      environment.systemPackages = with pkgs; [
        rustc
        rustfmt
        cargo
        clippy
      ];
    })
  ];
}
