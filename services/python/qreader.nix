{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  zbar
}:

buildPythonPackage rec {
  pname = "qreader";
  version = "3.16";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-8dc64e0c5a21e48e98df21836513b419b7fa8704";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
    zbar
  ];
}

