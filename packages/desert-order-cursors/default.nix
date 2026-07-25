{
  lib,
  stdenvNoCC,
  unzip,
}:
# Egyptian-themed cursor set from the EGYPT ORIGINS - DESERT ORDER theme.
# https://www.gnome-look.org/p/2370103
#
# pling's download links are JWT-signed, IP-bound and expire after a couple of
# days, so the archive is vendored instead of fetched.
stdenvNoCC.mkDerivation {
  pname = "desert-order-cursors";
  version = "0.1.0";

  src = ./DesertOrderCursors.zip;

  nativeBuildInputs = [ unzip ];
  sourceRoot = "DesertOrderCursors";

  installPhase = ''
    runHook preInstall
    install -dm755 $out/share/icons/DesertOrderCursors
    cp -r cursors index.theme $out/share/icons/DesertOrderCursors/
    runHook postInstall
  '';

  meta = {
    description = "Egyptian-inspired golden cursor theme from EGYPT ORIGINS - DESERT ORDER";
    homepage = "https://www.gnome-look.org/p/2370103";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
