{ pkgs, ... }:
(pkgs.buildFHSUserEnv {
    name = "rust-bevy-fhs";
    targetPkgs = pkgs: with pkgs; [
        pkg-config
        udev
        alsa-lib
        vulkan-loader
        xorg.libX11
        xorg.libXrandr
        xorg.libXcursor
        xorg.libXi
        xorg.libXtst
        libxkbcommon
        wayland
        openssl
        systemd.dev
    ];
    # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}).env
