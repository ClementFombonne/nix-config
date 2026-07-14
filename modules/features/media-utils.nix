{ self, ... }: {
  flake.nixosModules.media-utils = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ffmpeg
      swayimg
      wf-recorder
    ];
  };
}
