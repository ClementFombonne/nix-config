{ self, ... }: {
  flake.nixosModules.development = { pkgs, ... }: {
    # Java requires system-level enablement to correctly link /usr/bin/java and set JAVA_HOME
    programs.java = {
      enable = true;
      package = pkgs.jdk;
    };

    home-manager.users.clement.imports = [ self.homeModules.development ];
  };

  flake.homeModules.development = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Nix
      nixd
      nixfmt

      # C / C++
      gcc
      clang-tools

      # Python
      uv
      python314
      ruff
      ty

      # Typst
      typst
      tinymist

      # Rust
      cargo
      rustc
      clippy
      rustfmt
      rust-analyzer

      # Lua
      lua-language-server
      stylua

      # Java Build Tools
      maven
      gradle
    ];
  };
}
