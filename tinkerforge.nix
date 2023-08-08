{ pkgs ? (import <nixpkgs> {}).pkgs }:
with pkgs;

mkShell {
  nativeBuildInputs = [ pkgs.autoPatchelfHook ];

  buildInputs = [
    stdenv.cc.cc.lib
    python38Packages.virtualenv # run virtualenv .
    python38Packages.pyqt5 # avoid installing via pip
    python38Packages.pyusb # fixes the pyusb 'No backend available' when installed directly via pip
    python38Packages.tzlocal
    python38Packages.pyserial
    python38Packages.setuptools
    python38Packages.pytz
    python38Packages.pip
  ];
  shellHook = ''
    export PIP_PREFIX=$(pwd)/_build/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python38.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
    # fixes xcb issues :
    QT_PLUGIN_PATH=${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}
  '';
}
