{ pkgs, ... }:
pkgs.mkShell rec {
    nativeBuildInputs = with pkgs; [
        pkg-config
    ];
    buildInputs = with pkgs; [
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
    ];
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
}
