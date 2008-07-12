#!/bin/sh

#date := $(shell date "+%-d. %B %Y.")

all: sverapoj.html

%.html: %.docbook
	xmllint --valid $< >/dev/null
	date=`date "+%-d. %B %Y."`; \
vcsrev=`git log -n1 $< | head -1 | sed 's/^.* //'`; \
cat $< | sed "s/@date@/$$date/" | sed "s/@vcsrev@/$$vcsrev/" > $<.tmp
	xsltproc local.xsl $<.tmp >$@
	rm $<.tmp
	tidy -q --show-warnings no -utf8 -w 0 -m $@; test -z

clean:
	rm -f *.html
