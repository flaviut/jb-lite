{ lib
, stdenv
, python3
, installShellFiles
}:

let
  pythonEnv = python3.withPackages (ps: [ ps.brotli ]);
in
stdenv.mkDerivation {
  pname = "jb-lite";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ installShellFiles ];

  buildInputs = [ pythonEnv ];

  installPhase = ''
    install -Dm755 jb-lite $out/bin/jb-lite
    
    # Fix shebang to use the python environment with dependencies
    sed -i "1s|.*|#!${pythonEnv}/bin/python3|" $out/bin/jb-lite

    # Install systemd units
    install -Dm644 jb-lite-update.service $out/lib/systemd/user/jb-lite-update.service
    install -Dm644 jb-lite-update.timer $out/lib/systemd/user/jb-lite-update.timer

    # Generate completions
    ${pythonEnv}/bin/python3 jb-lite completion --shell bash > jb-lite.bash
    ${pythonEnv}/bin/python3 jb-lite completion --shell zsh > _jb-lite
    
    installShellCompletion --bash jb-lite.bash
    installShellCompletion --zsh _jb-lite
  '';

  meta = with lib; {
    description = "A lightweight, CLI-only package manager for JetBrains IDEs";
    homepage = "https://github.com/flaviut/jb-lite";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "jb-lite";
  };
}
