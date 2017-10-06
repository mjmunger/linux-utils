#!/bin/bash

# Resets the file permissions and ownership to the specified owner, and "normal" Linux file permissions.

usage() {

	echo "SUMMARY"
	echo "  Resets the file permissions and ownership of files and directories. This assumes the user and group are the same."
	echo ""
	echo "Usage:"
	echo "  fix-perms [TARGETPATH] [username]"
	exit 0
}

check_args() {
	USEREXITS=`/bin/grep -rin $USER /etc/passwd`
	if [ "$USEREXITS" = "" ]; then
		echo "User does not exist?"
		exit 1
	fi

	if [ ! -d $TARGETPATH ]; then
		echo "TARGETPATH ($TARGETPATH) does not exist!"
		exit 1;
	fi
}

fix_permissions() {
	cd $TARGETPATH
	chown -R $USER:$USER $TARGETPATH

	echo "Fixing file permissions..."
	/usr/bin/find . type -f -exec chmod 0644 {} \;

	echo "Fixing directory permissions..."
	/usr/bin/find . -type d -exec chmod 0755 {} \;

	echo "Done!"
}

# Script starts

if [ "$#" -ne 2 ]; then
	usage
fi

TARGETPATH=$1
USER=$2

check_args $TARGETPATH $USER 
fix_permissions $TARGETPATH $USER