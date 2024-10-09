{ lib, makeWrapper, appimageTools }:
let
  pwd = builtins.toString ./.;
  
  pname = "cider";
  version = "2.5.0";

  src = builtins.fetchurl {
    url = "file:///tmp/Cider-linux-appimage-x64.AppImage";
    sha256 = "sha256:1nm35psq9ddii2c15kb03ifcn43fimvc4yzb4cpm1gqsiz4w21qz";
  };

  desktopSrc = ./.;

in appimageTools.wrapType2 rec {

  inherit pname version src;

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

  extraInstallCommands = ''
    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/${pname} --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}} --no-sandbox"
    install -m 444 -D ${src} -t $out/bin

    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "A cross-platform Apple Music experience built on Vue.js and written from the ground up with performance in mind.";
    homepage = "https://cider.sh/";
    license = licenses.unfree;
    mainProgram = "cider";
    platforms = [ "x86_64-linux" ];
  };
}

