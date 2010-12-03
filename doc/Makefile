# -*- Makefile -*-

all: html

help:
	@echo -e "\tmake doc\t\tправи документацију у директоријуму doc/"

html: sverapoj.docbook
	rm -rf html && mkdir html
	# Generate HTML pages.
	xmllint --valid $< >/dev/null
	date=`date "+%-d. %B %Y."`; \
vcsrev=`git log -n1 $< | head -1 | sed 's/^.* //'`; \
cat $< | sed "s/@date@/$$date/" | sed "s/@vcsrev@/$$vcsrev/" > $<.tmp
	xsltproc local.xsl $<.tmp >html/index.html
	rm $<.tmp
	tidy -q --show-warnings no -utf8 -w 0 -m html/index.html; test -z
	# Link to date directory (style sheet, etc.)
	ln -sf ../html-data html/data
	# Remove title= attributes to sectioning classes,
	# because they cause a tooltip to be shown wherever the pointer is.
	perl -pi -e 's/(<div[^>]*?class="(abstract|article|book|chapter|sect)[^>]*?) *title=".*?"/\1/' html/index.html

clean:
	rm -rf html *.tmp

