{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  makeWrapper,
  cli11,
  curl,
  hwloc,
  igsc,
  level-zero,
  libpciaccess,
  nlohmann_json,
  # Level Zero GPU driver, loaded at runtime.
  intel-compute-runtime,
  intel-graphics-compiler,
  # Optional runtime helpers shelled out to by `xpu-smi dump --debug-log`.
  clinfo,
  dmidecode,
  libva-utils,
  pciutils,
  usbutils,
}:
let
  # nixpkgs ships igsc 0.9.6, which predates igsc_device_oem_serial_number();
  # xpum 2.0 calls it, and upstream's conan recipe pins 1.2.0 anyway.
  # The upstream build also expects to find igsc through pkg-config, but igsc
  # only installs a CMake config, so the .pc file is added here.
  igscVersion = "1.2.0";
  igsc' = igsc.overrideAttrs {
    version = igscVersion;
    src = fetchFromGitHub {
      owner = "intel";
      repo = "igsc";
      tag = "V${igscVersion}";
      hash = "sha256-y50DZjE0ZpiDZanDjRotarbFweSbrN/WXrKMNmNFWus=";
    };
    postInstall = ''
      install -Dm644 /dev/stdin $out/lib/pkgconfig/igsc.pc <<EOF
      prefix=$out
      libdir=\''${prefix}/lib
      includedir=\''${prefix}/include

      Name: igsc
      Description: Intel Graphics System Controller firmware update library
      Version: ${igscVersion}
      Libs: -L\''${libdir} -ligsc
      Cflags: -I\''${includedir}
      EOF
    '';
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "xpumanager";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "intel";
    repo = "xpumanager";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2M/9M0r0z2wWtOeKm3Y6yAR0TT6KbVh3Fnbkm4D68Us=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    cli11
    curl
    hwloc
    igsc'
    level-zero
    libpciaccess
    nlohmann_json
  ];

  mesonFlags = [
    # Upstream builds with -Werror plus a long GCC warning list; compilers newer
    # than the tested GCC 13 trip over it.
    (lib.mesonBool "dev" true)
  ];

  # Upstream defaults to b_lto=true, and plain binutils `ar` does not load the
  # LTO plugin, so the static libraries end up with an index that hides every
  # symbol ("undefined reference to TableBuilder::addColumn" et al when linking
  # table_example / xpu-smi). The gcc wrappers pass --plugin for us.
  # Exported here rather than through `env` because the bintools setup hook
  # resets AR/NM/RANLIB to the plain binutils ones during the setup phase.
  preConfigure = ''
    export AR=${stdenv.cc.targetPrefix}gcc-ar
    export NM=${stdenv.cc.targetPrefix}gcc-nm
    export RANLIB=${stdenv.cc.targetPrefix}gcc-ranlib
    type -p "$AR"
  '';

  # xpu-smi calls zesInit() *and* zeInit(), so it needs the Level Zero GPU
  # driver (libze_intel_gpu.so.1, the "drivers" output of
  # intel-compute-runtime) and, because that driver dlopens the graphics
  # compiler during zeInit, libigc.so.2 next to it. nixpkgs only fixes up the
  # runpath of the OpenCL driver in the main output, so the Level Zero one
  # finds neither on its own and aborts inside GmmLib. /run/opengl-driver/lib
  # comes first so a driver installed through hardware.graphics still wins.
  postFixup = ''
    wrapProgram $out/bin/xpu-smi \
      --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib:${
        lib.makeLibraryPath [
          intel-compute-runtime.drivers
          intel-graphics-compiler
        ]
      }" \
      --prefix PATH : ${
        lib.makeBinPath [
          clinfo
          dmidecode
          libva-utils
          pciutils
          usbutils
        ]
      }
  '';

  meta = {
    description = "Intel XPU Manager: CLI for monitoring and managing Intel data center and Arc GPUs";
    homepage = "https://github.com/intel/xpumanager";
    changelog = "https://github.com/intel/xpumanager/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "xpu-smi";
    platforms = [ "x86_64-linux" ];
  };
})
