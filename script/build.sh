#!/bin/sh

echo "=== start build process =="

# disable editor on dch
export EDITOR=true

# sign data
export DEBEMAIL="release@yavdr.org"
export DEBFULLNAME="yaVDR Release-Team"

PACKAGE_NAME=$1
BRANCH=$2
DIST=$3
STAGE=$4
SECTION=$5
GITREPO=$6
URGENCY=$7
VERSION_SUFFIX="-0yavdr0~${DIST}"
DATE=`date +"%Y%m%d%H%M%S"`

if [ ${SECTION} = "main" ]; then
  LPREPO="main"
else
  LPREPO="${STAGE}-${SECTION}"
fi

PACKAGE_VERSION="${DATE}${STAGE}"
PACKAGE_NAME_VERSION="${PACKAGE_NAME}_${PACKAGE_VERSION}"
ORIG_FILE="${PACKAGE_NAME_VERSION}.orig.tar.gz"

echo "-- directory: ${PWD}"
echo "-- package name: ${PACKAGE_NAME}"
echo "-- branch: ${BRANCH}"
echo "-- dist: ${DIST}"
echo "-- stage: ${STAGE}"
echo "-- section: ${SECTION}"
echo "-- git repo: ${GITREPO}"
echo "-- lp repo: ${LPREPO}"
echo "-- package version: ${PACKAGE_VERSION}"
echo "-- package name version: ${PACKAGE_NAME_VERSION}"
echo "-- orig file: ${ORIG_FILE}"

echo "=== checkout sourcecode ==="
git clone -b $BRANCH -q $GITREPO $PACKAGE_NAME_VERSION
cd $PACKAGE_NAME_VERSION
COMMIT_ID=`git rev-parse HEAD`
echo "-- commit id: ${COMMIT_ID}"
echo "-- remove .git"
rm .git -rf
cd ..

echo "=== create orig file ==="
tar czf $ORIG_FILE $PACKAGE_NAME_VERSION --exclude="debian"

cd $PACKAGE_NAME_VERSION

echo "=== changelog ==="
rm debian/changelog
dch -v "${PACKAGE_VERSION}${VERSION_SUFFIX}" "Autobuild - ${COMMIT_ID}
${GITREPO}" --create --distribution=$DIST -u $URGENCY --package "${PACKAGE_NAME}"
cat debian/changelog

echo "=== debuild ==="
debuild -S -sa

cd ..

echo "=== upload ==="
dput ppa:yavdr/${STAGE}-${SECTION} "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}_source.changes"

echo "=== cleanup ==="
rm -rf $PACKAGE_NAME_VERSION
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}.orig.tar.gz"
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}.debian.tar.gz"
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}.dsc"
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}_source.ppa.upload"
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}_source.build"
rm -rf "${PACKAGE_NAME_VERSION}${VERSION_SUFFIX}_source.changes"
