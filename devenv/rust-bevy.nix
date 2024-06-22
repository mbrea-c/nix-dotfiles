{ inputs, pkgs, ... }:
inputs.devenv.lib.mkShell {
    inherit inputs pkgs;
    modules = [
        ({ pkgs, config, ...}: {
            packages = with pkgs; [
                nil
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
            enterShell = ''
                echo "Hello, and good luck!"
            '';
        })
    ];
}
