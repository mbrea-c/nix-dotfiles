{ pkgs, ... }:
(pkgs.buildFHSUserEnv {
    name = "rust-bevy-fhs";
    targetPkgs = pkgs: with pkgs; [
        pkg-config
        udev.dev
        alsa-lib.dev
        vulkan-loader.dev
        xorg.libX11.dev
        xorg.libXrandr.dev
        xorg.libXcursor.dev
        xorg.libXi.dev
        xorg.libXtst.dev
        libxkbcommon.dev
        wayland.dev
        openssl.dev
        systemd.dev
    ];
    # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}).env
