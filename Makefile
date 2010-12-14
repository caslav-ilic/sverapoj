# -*- Makefile -*-
# Аутоматизација изградње појмовника.  
# Идеално, комплетан појмовник, у свим форматима, треба да се добије
# куцањем само једне наредбе у командној линији.

# Подешавања команди и локалитета
include Settings.common

# ############################################################
# Ако је све у реду, нећете морати да прегледате и мењате
# команде испод овог коментара.
# ############################################################

.PHONY:  all check clean help process doc

DVG_SETTINGS_FILES:=$(wildcard Settings.dvg-*)
DVG_TARGETS:=$(patsubst Settings.%,%,$(DVG_SETTINGS_FILES))

help:
	@echo -e "Доступни циљеви:\n"
	@echo -e "\tРежијски циљеви:\n"
	@echo -e "\tmake all\t\tгради све доступне формате појмовника"
	@echo -e "\tmake check\t\tпроверава исправност појмовника"
	@echo -e "\tmake clean\t\tуклања генерисане датотеке"
	@echo -e "\tmake doc\t\tгради документацију (make all у doc/)"
	@echo -e "\tmake www\t\tгради поједине формате појмовника"
	@echo -e "\t\t\t\tи документације и синхронизује веб сајт"
	@echo -e "\t\t\t\t(неопходан алијас www-sverapoj у постави ССХ-а)"
	@echo -e "\tmake help\t\tисписује ову помоћ"
	@echo -e "\n\tИзградња појмовника:\n"
	@for a in $(DVG_SETTINGS_FILES); do make -s -f $$a help; done

all: check $(DVG_TARGETS)

doc:
	make -C doc all

check: 
	$(DGPROC) $(TOP_XML)

clean:
	$(RM) *~ $(DVG_TARGETS)

dvg-%: $(TOP_XML) $(DEPS)
	INCLUDEMAKE="Settings.$@" make -f Makefile.common common

www: dvg-html doc
	cp -a www www-tmp
	rm www-tmp/README
	ln -s ../dvg-html www-tmp/gloss
	ln -s ../doc/html www-tmp/doc
	rsync -raLv --delete www-tmp/ www-sverapoj:sverapoj.nedohodnik.net/
	rm -rf www-tmp
