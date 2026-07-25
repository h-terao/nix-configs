{
  lib,
  stdenvNoCC,
}:
# Animated cursor theme featuring Ellen Joe from Zenless Zone Zero.
# https://www.gnome-look.org/p/2166863
#
# pling's download links are JWT-signed, IP-bound and expire after a couple of
# days, so the archive is vendored instead of fetched.
stdenvNoCC.mkDerivation {
  pname = "ellen-joe-cursors";
  version = "2024-06-19";

  src = ./Ellen-Joe.tar.gz;
  sourceRoot = "Ellen-Joe";

  installPhase = ''
    runHook preInstall
    install -dm755 $out/share/icons/Ellen-Joe
    cp -r cursors index.theme $out/share/icons/Ellen-Joe/
    runHook postInstall
  '';

  meta = {
    description = "Animated cursor theme featuring Ellen Joe from Zenless Zone Zero";
    homepage = "https://www.gnome-look.org/p/2166863";
    platforms = lib.platforms.linux;
  };
}
