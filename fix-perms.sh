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
	USEREXITS=`grep -rin $USER /etc/passwd`
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

	echo "Fixing $TARGETPATH..."

	echo "Changing ownership to: $USER"
	chown -R $USER:$USER $TARGETPATH

	echo "Fixing file permissions..."
	find . -type f -exec chmod 0640 {} \;

	echo "Fixing directory permissions..."
	find . -type d -exec chmod 0750 {} \;

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