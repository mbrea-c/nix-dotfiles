{ ... }: {
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = { ovmf.enable = true; };
    };
    spiceUSBRedirection.enable = true;
  };

}
