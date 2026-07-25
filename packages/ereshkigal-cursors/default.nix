{
  lib,
  stdenvNoCC,
}:
# Cursor theme featuring Ereshkigal from Fate/Grand Order.
# https://www.gnome-look.org/p/2251935
#
# pling's download links are JWT-signed, IP-bound and expire after a couple of
# days, so the archive is vendored instead of fetched.
stdenvNoCC.mkDerivation {
  pname = "ereshkigal-cursors";
  version = "2025-01-24";

  src = ./Ereshkigal.tar.gz;
  sourceRoot = "Ereshkigal";

  installPhase = ''
    runHook preInstall
    install -dm755 $out/share/icons/Ereshkigal
    cp -r cursors index.theme $out/share/icons/Ereshkigal/
    runHook postInstall
  '';

  meta = {
    description = "Cursor theme featuring Ereshkigal from Fate/Grand Order";
    homepage = "https://www.gnome-look.org/p/2251935";
    platforms = lib.platforms.linux;
  };
}
