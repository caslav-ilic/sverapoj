# -*- Makefile -*-
ALL_SOURCES:=$(wildcard *.docbook)
ALL_TARGETS:=$(patsubst %.docbook,%.html,$(ALL_SOURCES))

all: $(ALL_TARGETS)

help:
	@echo -e "\tmake doc\t\tправи документацију у директоријуму doc/"

%.html: %.docbook
	xmllint --valid $< >/dev/null
	date=`date "+%-d. %B %Y."`; \
vcsrev=`git log -n1 $< | head -1 | sed 's/^.* //'`; \
cat $< | sed "s/@date@/$$date/" | sed "s/@vcsrev@/$$vcsrev/" > $<.tmp
	xsltproc local.xsl $<.tmp >$@
	rm $<.tmp
	tidy -q --show-warnings no -utf8 -w 0 -m $@; test -z

clean:
	rm -f *.html *~

