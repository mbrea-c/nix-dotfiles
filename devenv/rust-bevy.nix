{ pkgs, ... }:
pkgs.mkShell rec {
    nativeBuildInputs = with pkgs; [
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
    ];
    buildInputs = with pkgs; [
    ];
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (buildInputs ++ buildInputs);
}
