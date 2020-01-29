#!/bin/sh

PREFIX=/usr/local/bin

INSTALL() {
	echo "installing to $PREFIX ..."
	cp cmus-notify.pl $PREFIX/cmus-notify
	chmod 755 $PREFIX/cmus-notify
	echo "installed"
}

UNINSTALL() {
	rm $PREFIX/cmus-notify
	echo "removed $PREFIX/cmus-notify"
	echo "uninstalled. config and cache files may remain in ~/.config/cmus"
}

[ -n "$1" ] || exit
[ "$1" = "install" ] && INSTALL
[ "$1" = "uninstall" ] && UNINSTALL
