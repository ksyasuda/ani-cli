PREFIX := /usr

all: install

install: uninstall
	install -m0755 ani-cli $(DESTDIR)$(PREFIX)/bin/ani-cli
	install -m0755 aniwrapper $(DESTDIR)$(PREFIX)/bin/aniwrapper
	mkdir -p /usr/local/man/man1
	install -m0644 docs/man/aniwrapper.1 /usr/local/man/man1/
	gzip -qf /usr/local/man/man1/aniwrapper.1
	mandb -q

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

.PHONY: all install uninstall dev
