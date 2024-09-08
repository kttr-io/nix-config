final: prev:
let
  chromiumFlags = [
    "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoEncoder"
    "--ozone-platform-hint=auto"
  ];

  chromiumPackages = [
    "brave"
    "chromium"
    "google-chrome"
  ];
in
prev.lib.genAttrs chromiumPackages (package: prev.${package}.override { commandLineArgs = chromiumFlags; })
