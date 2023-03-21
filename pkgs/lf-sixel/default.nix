{
  stdenv,
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:
buildGoModule rec {
  pname = "lf-sixel";
  version = "28-1";

  src = fetchFromGitHub {
    owner = "horriblename";
    repo = "lf";
    rev = "r${version}";
    hash = "sha256-FBjvZueSh9+grdDrD8DTOlJb6GaCQuJhrsOXRwlpDSQ=";
  };

  nativeBuildInputs = [installShellFiles];

  vendorHash = "sha256-oIIyQbw42+B6T6Qn6nIV62Xr+8ms3tatfFI8ocYNr0A=";

  ldflags = ["-s" "-w" "-X main.gVersion=r${version}"];

  tags = lib.optionals (!stdenv.isDarwin) ["osusergo"];

  postInstall = ''
    install -D --mode=444 lf.desktop $out/share/applications/lf.desktop
    installManPage lf.1
    installShellCompletion etc/lf.{bash,zsh,fish}
  '';

  meta = with lib; {
    description = "Sixel fork of lf, a terminal file manager written in Go and heavily inspired by ranger";
    homepage = "https://github.com/horriblename/lf";
    license = licenses.mit;
    maintainers = with maintainers; [shebang];
  };
}
