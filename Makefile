PREFIX := /usr

all: install

install:
	cp ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	cp aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/ani-cli
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/aniwrapper

dev:
	$(RM) $(DESTDIR)$(PREFIX)/bin/ani-cli
	$(RM) $(DESTDIR)$(PREFIX)/bin/aniwrapper
	ln -sr ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	ln -sr aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/ani-cli
	$(RM) $(DESTDIR)$(PREFIX)/bin/aniwrapper

reinstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/ani-cli
	$(RM) $(DESTDIR)$(PREFIX)/bin/aniwrapper
	cp ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	cp aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/ani-cli
	chmod 0755 $(DESTDIR)$(PREFIX)/bin/aniwrapper

.PHONY: all install uninstall dev reinstall

