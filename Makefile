PREFIX=/usr/local

install:
	@printf "Installing to ${DESTDIR}${PREFIX}/bin...\n"
	install -Dm755 cmus-notify.pl ${DESTDIR}${PREFIX}/bin/cmus-notify
	@printf "Installed!\n"

uninstall:
	rm ${PREFIX}/bin/cmus-notify
	@printf "Removed ${PREFIX}/bin/cmus-notify.\n"
	@printf "Configuration and cache files may still be present in cmus configuration directory."
