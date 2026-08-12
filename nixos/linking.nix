{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      # Basic runtime libraries
      stdenv.cc.cc
      zlib
      openssl

      # X11 / AWT
      libx11
      libxext
      libxrender
      libxtst
      libxi
      libxrandr
      libxfixes
      libxcomposite
      libxdamage
      libxcb
      libxkbcommon

      # Graphics and desktop integration
      libglvnd
      glib
      gtk3

      # Fonts
      fontconfig
      freetype

      # Audio and printing
      alsa-lib
      cups
      openal
    ];
  };
}
