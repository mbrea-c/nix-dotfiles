{ pkgs, ... }:
(pkgs.buildFHSUserEnv {
  name = "rust-bevy-fhs";
  targetPkgs = pkgs:
    with pkgs; [
      pkg-config
      udev.dev
      alsa-lib.dev
      vulkan-loader.dev
      glfw
      xorg.libX11.dev
      xorg.libXrandr.dev
      xorg.libxcb
      xorg.libXcursor
      xorg.libXi
      xorg.libXtst
      libxkbcommon
      libxkbcommon.dev
      wayland.dev
      openssl.dev
      systemd.dev
      fontconfig.dev
      freetype.dev
    ];
  runScript = "${pkgs.zsh}/bin/zsh";
  # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}).env
