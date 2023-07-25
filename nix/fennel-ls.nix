{
  stdenv,
  makeWrapper,
  lua,
  ...
}:
stdenv.mkDerivation {
  pname = "fennel-ls";
  version = " e7c642e1";
  buildInputs = [lua makeWrapper];

  installFlags = ["PREFIX=${placeholder "out"}"];

  src = builtins.fetchGit {
    url = "https://git.sr.ht/~xerool/fennel-ls";
    ref = "main";
    rev = "e7c642e12a15c6d452559414ee1890b30f4e8406";
  };
}
