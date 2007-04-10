#!/bin/sh

#
# Helps generate autoconf/automake stuff, when code is checked out from SCM.
#
# Copyright (C) 2006 - Karel Zak <kzak@redhat.com> 
#

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=. 

THEDIR=`pwd`
cd $srcdir
DIE=0

(autopoint --version) < /dev/null > /dev/null 2>&1 || {
        echo
        echo "You must have autopoint installed to generate util-linux-ng build system.."
        echo "Download the appropriate package for your distribution,"
        echo "or see http://www.gnu.org/software/gettext"
        DIE=1
}
(autoconf --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have autoconf installed to generate util-linux-ng build system."
	echo
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/autoconf"
	DIE=1
}
(automake --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have automake installed to generate util-linux-ng build system."
	echo 
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/automake"
	DIE=1
}
(autoheader --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have autoheader installed to generate util-linux-ng build system."
	echo 
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/autoheader"
	DIE=1
}
(libtool --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have libtool installed to generate util-linux build-system."
	echo "Download the appropriate package for your distribution,"
	echo "or see http://www.gnu.org/software/libtool"
	DIE=1
}
if test "$DIE" -eq 1; then
	exit 1
fi

test -f mount/mount.c || {
	echo "You must run this script in the top-level util-linux-ng directory"
	exit 1
}

set -e
autopoint --force
libtoolize --copy --force
aclocal -I m4
automake --add-missing
autoconf
autoheader

cd $THEDIR

echo 
echo "Now type './configure' and 'make' to compile."
echo 


