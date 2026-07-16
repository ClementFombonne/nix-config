{ self, ... }: {
  flake.nixosModules.core-user =
    { pkgs, ... }:
    let
      modules = with self.nixosModules; [
        zsh
      ];
    in
    {
      imports = modules;
      users.users.clement = {
        isNormalUser = true;
        initialPassword = "password";
        shell = pkgs.zsh;
        description = "clement";
        extraGroups = [
          "root"
          "wheel"
        ];
      };
    };
}
