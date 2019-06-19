#!/bin/sh
cd `dirname $0`
here=$PWD

cd ..
#svn ps svn:externals -F install/svn.externals .
svn ps svn:ignore -F install/svn.ignore.root .
svn ps svn:ignore -F install/svn.ignore.config config
svn ps svn:ignore -F install/svn.ignore.docroot docroot
