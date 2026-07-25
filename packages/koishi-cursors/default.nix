{
  lib,
  stdenvNoCC,
  unzip,
}:
# Animated Touhou cursor theme featuring Koishi Komeiji.
# https://www.gnome-look.org/p/1847757
#
# pling's download links are JWT-signed, IP-bound and expire after a couple of
# days, so the archive is vendored instead of fetched.
stdenvNoCC.mkDerivation {
  pname = "koishi-cursors";
  version = "2022-07-06";

  src = ./Koishi.zip;

  nativeBuildInputs = [ unzip ];
  sourceRoot = "Koishi";

  installPhase = ''
    runHook preInstall
    install -dm755 $out/share/icons/Koishi
    cp -r cursors index.theme $out/share/icons/Koishi/
    runHook postInstall
  '';

  meta = {
    description = "Animated Touhou cursor theme featuring Koishi Komeiji";
    homepage = "https://www.gnome-look.org/p/1847757";
    platforms = lib.platforms.linux;
  };
}
