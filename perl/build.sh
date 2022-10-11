#!/bin/bash

APPNAME=perl
VERSION=5.36.0
DIRNAME=${APPNAME}-${VERSION}
ARCHIVE=${DIRNAME}.tar.gz
URL=https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz

# Clean up
rm -rf ${ARCHIVE}
rm -rf ${DIRNAME}

echo -n "Downloading ${APPNAME} sources ... "
wget -q ${URL}
if test $? -ne 0; then
    echo ""
    echo "Unable to download ${APPNAME} from ${URL}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Unpacking gzip ... "
tar xzf ${ARCHIVE}
if test $? -ne 0; then
    echo ""
    echo "Unable to extract ${APPNAME}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Building ${APPNAME} ... "
pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

./Configure -des
patch Makefile < ../patches/Makefile.patch
make

popd > /dev/null 2>&1 || exit 1

cp ${DIRNAME}/perl .

# rm -rf ${DIRNAME}
# rm -rf ${ARCHIVE}

echo -n "Build complete!"
