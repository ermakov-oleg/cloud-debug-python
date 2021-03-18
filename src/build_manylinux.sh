#!/bin/sh

docker run --rm -it -v $(pwd):/src quay.io/pypa/manylinux2014_x86_64 bash -c '\
  set -ex;
  cd /src;
  PYTHON=/opt/python/cp38-cp38/bin/python ./build.sh;
  /opt/python/cp38-cp38/bin/python setup.py bdist_wheel;
  mv dist dist_tmp;
  PYTHON=/opt/python/cp39-cp39/bin/python ./build.sh;
  /opt/python/cp39-cp39/bin/python setup.py bdist_wheel;
  mv dist/* dist_tmp/;
  auditwheel repair dist_tmp/*38*.whl -w dist/;
  auditwheel repair dist_tmp/*39*.whl -w dist/;
  rm -rf dist_tmp/;
'
