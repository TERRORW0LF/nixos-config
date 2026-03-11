{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  name = "static-config";
  src = ./.;
  installPhase = ''
    	mkdir -p $out/
    	cp -r ./* $out/
  '';
}
