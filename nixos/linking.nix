{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      xorg.libXrandr
      xorg.libX11
      libglvnd
      freetype
      zlib
      openal
      openssl
      # localectl
    ];
  };
}
