include version.mk

BIN = gpm
MAN = $(BIN:=.1)
DIST = $(BIN)$(V)
TARBALL = $(DIST).tar.gz

PREFIX ?= $(DESTDIR)/usr/local
MANPREFIX ?= $(PREFIX)/man

INSTALL ?= install

bindir = $(PREFIX)/bin
mandir = $(MANPREFIX)/man1

all:
	@echo type \`make install\' to install gpm

install:
	mkdir -p $(bindir)
	$(INSTALL) -m 755 $(BIN) $(bindir)
	mkdir -p $(mandir)
	$(INSTALL) -m 644 $(MAN) $(mandir)

uninstall:
	cd $(bindir) && rm -f $(BIN)
	cd $(mandir) && rm -f $(MAN)

clean:
	-rm -rf $(TARBALL) $(DIST)

dist: clean
	mkdir -p $(DIST)
	cp -rf CHANGES COPYING Makefile README pm2gpm version.mk $(BIN) $(MAN) \
	    $(DIST)
	tar cf - $(DIST) | gzip >$(TARBALL)
	rm -rf $(DIST)

.PHONY: all install uninstall clean dist
