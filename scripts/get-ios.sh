#!/bin/sh

pushd "`dirname "$0"`" > /dev/null
scriptpath="`pwd`"
popd > /dev/null

. "$scriptpath/include.sh/build-dep.sh"

deps="ctemplate-ios libetpan-ios tidy-html5-ios"
for dep in $deps ; do
  name="$dep"
  get_prebuilt_dep
done
