# nix-config


## Installation

1. Partition the disk an mount filesystems below `/mnt`

    ```shell
    nix-shell -p disko

    # WARNING: this is destructive, double check the disk configuration of
    #   <your-hostname> before running disko!
    sudo disko --mode disko --flake github:kttr-io/nix-config#<your-hostname>
    ```
1. Install the system 
    ```shell
    sudo nixos-install --flake github:kttr-io/nix-config#<your-hostname>
    ```
