let
  intelFlags = [
    "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder"
  ];

  nvidiaWaylandFlags = [
    "--disable-gpu-compositing"
  ];

  chromiumPackages = [
    # Chromium browsers
    "brave"
    "chromium"
    "google-chrome"

    # Electron apps
    "vscode"
  ];

  mkChromiumFlags = flags: final: prev: prev.lib.genAttrs chromiumPackages (package: prev.${package}.override { commandLineArgs = flags; });
in
{
  intel = mkChromiumFlags intelFlags;
  nvidiaWayland = mkChromiumFlags nvidiaWaylandFlags;
}

