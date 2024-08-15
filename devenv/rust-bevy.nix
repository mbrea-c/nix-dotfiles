{ pkgs, ... }:
(pkgs.buildFHSUserEnv {
  name = "rust-bevy-fhs";
  targetPkgs = pkgs:
    with pkgs; [
      pkg-config
      udev.dev
      alsa-lib.dev
      vulkan-loader.dev
      xorg.libX11
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXi
      xorg.libXtst
      libxkbcommon.dev
      wayland.dev
      openssl.dev
      systemd.dev
      fontconfig.dev
      freetype.dev
    ];
  # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}).env
