#!/bin/bash

# Resets the file permissions and ownership to the specified owner, and "normal" Linux file permissions.

usage() {

	echo "SUMMARY"
	echo "  Resets the file permissions and ownership of files and directories. This assumes the user and group are the same."
	echo ""
	echo "Usage:"
	echo "  fix-perms [path] [username]"
	exit 0
}

check_args() {
	USEREXITS = `grep /etc/passwd $USER`
	if [ "$USEREXITS" = "" ]; then
		echo "User does not exist?"
		exit 1
	fi

	if [ ! -d $PATH ]; then
		echo "Path ($PATH) does not exist!"
		exit 1;
	fi
}

fix_permissions() {
	cd $PATH
	chown -R $USER:$USER $PATH

	echo "Fixing file permissions..."
	find . type -f -exec chmod 0644 {} \;

	echo "Fixing directory permissions..."
	find . -type d -exec chmod 0755 {} \;

	echo "Done!"
}

# Script starts

if [ "$#" -ne 2 ]; then
	usage
fi

PATH=$1
USER=$2

check_args $PATH $USER 
fix_permissions $PATH $USER