{ pkgs, ... }: {
  rust-bevy-fhs = (pkgs.buildFHSUserEnv {
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
  }).env;

  rust-bevy = pkgs.mkShell rec {
    nativeBuildInputs = with pkgs; [
      pkg-config
      ldtk
      (pkgs.rust-bin.stable.latest.default.override {
        extensions = [ "rust-src" ];
      })
    ];

    buildInputs = with pkgs; [
      udev
      alsa-lib
      vulkan-loader
      # X11
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr
      # Wayland
      libxkbcommon
      wayland
    ];

    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;

  };
}
