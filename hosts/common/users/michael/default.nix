{ inputs
, lib
, config
, pkgs
, ...
}: {
  users.users = {
    michael = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8j5K3v9B8orOQ5P/lxIKxh+isxWoBXD9wLfGHRCpAhiYUX1QHJJIFS5HvJR1jwT6pPNjtjCzxP0FXg5u4f5RIz19fCAl9F69c6ANdr34nXY5CuQzzizc+M6Ta78WzaHy4eqA6YGAs4oiMAh/HifM90ERkgGRv4vK0M2aysiOut/zfkWi/mAMD3qHwtuQ5bEX8HGley1BG22ypYK28MwHx3Sn9YVii2u731LKJKZ7D3T2kGqDkU9xsVEPIx7cLoqtY/TPZjLG8qpHbPLcNevQC49iKhzoWCU+niCfzX11+r83lTXuEBQUpzqTTAlim3P32Y9EcTjVkDFHJqn+v8Baf"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKlNSgglY6iQGMZYQxBq0dQe0oTyNWupKNWiVaWSwIuFAAAAFXNzaDpta29ldHRlci0xNjY2Njk2Mg=="
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFVeV5Uk7FV6YufANuKlNgjySIVBoBHo2QJVR/MnpHeuAAAAFXNzaDpta29ldHRlci0xODY5MTU0OQ=="
      ];
      extraGroups = [ "wheel" ];
    };
  };
}
