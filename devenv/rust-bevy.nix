{ pkgs, ... }:
(pkgs.buildFHSUserEnv {
  name = "rust-bevy-fhs";
  targetPkgs = pkgs:
    with pkgs; [
      pkg-config
      udev.dev
      alsa-lib.dev
      vulkan-loader.dev
      vulkan-headers
      vulkan-tools
      glfw
      shaderc
      libGL.dev
      xorg.libX11.dev
      xorg.libXrandr.dev
      xorg.libxcb.dev
      xorg.libXcursor.dev
      xorg.libXi.dev
      xorg.libXtst
      libxkbcommon.dev
      libxkbcommon
      wayland.dev
      openssl.dev
      systemd.dev
      fontconfig.dev
      freetype.dev
    ];
  runScript = "${pkgs.zsh}/bin/zsh";
  # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}).env
