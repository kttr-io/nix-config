# nix-config


## Installation

1. Clone this repository

    ```shell
    nix-shell -p git

    # If you have SSH Credentials - this also allows pushing config changes later
    git clone git@github.com:kttr-io/nix-config.git

    # If you don't have SSH Credentials
    git clone https://github.com/kttr-io/nix-config.git
    ```

1. Partition the disk an mount filesystems below `/mnt`

    ```shell
    nix-shell -p disko

    # WARNING: this is destructive, double check the disk configuration of
    #   <your-hostname> before running disko!
    sudo disko --mode disko --flake path:$(pwd)/nix-config#<your hostname>
    ```

1. Now might be a good time to update the hardware config of the host

    ```shell
    (sudo nixos-generate-config --no-filesystems --show-hardware-config) > nix-config/hosts/<your-hostname>/hardware.nix
    ```

1. Install the system

    ```shell
    nix-shell -p git

    sudo nixos-install --no-root-passwd --flake path:$(pwd)/nix-config#<your-hostname>
    ```

1. **If you made changes to the config, now would be a good time to commit them.**

1. Reboot
   > You should be able to login with user `michael` and the default initial password `correcthorsebatterystaple`.
   > **Change the password as soon as possible!**
