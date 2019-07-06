#!/bin/sh

PREFIX=/usr/local/bin
CFGDIR=/usr/share/cmus

INSTALL() {
	echo "installing to $PREFIX ..."
	cp cmus-notify.pl $PREFIX/cmus-notify
	echo "copying cmus-notify to $PREFIX"
	cp cmus_notify.sh $PREFIX/
	echo "copying cmus_notify.sh to $PREFIX"
	chmod 755 $PREFIX/cmus-notify
	chmod 755 $PREFIX/cmus_notify.sh
	if [ -f $CFGDIR ]; then
		echo "bailing -- $CFGDIR not a valid dir"
		exit
	else
		cp notify.cfg $CFGDIR/
		echo "copying notify.cfg to $CFGDIR"
		chmod 644 $CFGDIR/notify.cfg
	fi
	echo "installed"
}

UNINSTALL() {
	rm $PREFIX/cmus-notify
	echo "removed $PREFIX/cmus-notify"
	rm $PREFIX/cmus_notify.sh
	echo "removed $PREFIX/cmus_notify.sh"
	rm $CFGDIR/notify.cfg
	echo "removed $CFGDIR/notify.cfg"
	echo "uninstalled"
}

[ -n "$1" ] || exit
[ "$1" = "install" ] && INSTALL
[ "$1" = "uninstall" ] && UNINSTALL
