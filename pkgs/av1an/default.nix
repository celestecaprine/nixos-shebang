{
  config,
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  ffmpeg_5-full,
  python310Packages,
  vapoursynth,
  libclang,
  nasm,
  stdenv,
}:
rustPlatform.buildRustPackage rec {
  pname = "av1an";
  version = "0.4.0-release";

  src = fetchFromGitHub {
    owner = "master-of-zen";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-HIhrloYNzW0lH47jc/aFH1Z9XYL8HksES2pwyCBTLE4=";
  };

  preBuild = ''
    # From: https://github.com/NixOS/nixpkgs/blob/1fab95f5190d087e66a3502481e34e15d62090aa/pkgs/applications/networking/browsers/firefox/common.nix#L247-L253
    # Set C flags for Rust's bindgen program. Unlike ordinary C
    # compilation, bindgen does not invoke $CC directly. Instead it
    # uses LLVM's libclang. To make sure all necessary flags are
    # included we need to look in a few places.
    export BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
      $(< ${stdenv.cc}/nix-support/libc-cflags) \
      $(< ${stdenv.cc}/nix-support/cc-cflags) \
      $(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
      ${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"} \
      ${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${lib.getVersion stdenv.cc.cc}/include"} \
    "
  '';
  buildType = "release";
  cargoSha256 = "sha256-ZDuTDFRkVSfNcs7CqRTbIh3TIERaOKsoEop15o3DA5g=";
  baseInputs = [python310Packages.vapoursynth];
  buildInputs = [stdenv.cc.libc ffmpeg_5-full vapoursynth nasm libclang];
  LIBCLANG_PATH = "${libclang.lib}/lib";
  doCheck = false; # Integration tests do not work in sandbox enviroment
  nativeBuildInputs = [ffmpeg_5-full vapoursynth nasm pkg-config];

  meta = with lib; {
    description = "Cross-platform command-line AV1 / VP9 / HEVC / H264 encoding framework with per scene quality encoding";
    homepage = "https://github.com/master-of-zen/Av1an";
    license = licenses.gpl3;
    maintainers = with maintainers; [master-of-zen];
    platforms = platforms.linux;
  };
}
