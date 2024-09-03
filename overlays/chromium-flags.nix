final: prev:
let
  chromiumFlags = [
    "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder"
    "--gtk-version=4"
  ];

  chromiumPackages = [
    "brave"
    "chromium"
    "google-chrome"
  ];
in
prev.lib.genAttrs chromiumPackages (package: prev.${package}.override { commandLineArgs = chromiumFlags; })
