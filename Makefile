PREFIX := /usr

all: install

install: uninstall
	cp ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	cp aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/ani-cli
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/aniwrapper

dev: uninstall
	ln -sr ./ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	ln -sr ./aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper

uninstall:
ifneq ("$(wildcard $(DESTDIR)$(PREFIX)/bin/ani-cli)","")
	$(RM) $(DESTDIR)$(PREFIX)/bin/ani-cli
endif
ifneq ("$(wildcard $(DESTDIR)$(PREFIX)/bin/aniwrapper)","")
	$(RM) $(DESTDIR)$(PREFIX)/bin/aniwrapper
endif

reinstall: uninstall install

.PHONY: all install uninstall dev reinstall

