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

.PHONY:  all check clean help process

DVG_SETTINGS_FILES:=$(wildcard Settings.dvg-*)
DVG_TARGETS:=$(patsubst Settings.%,%,$(DVG_SETTINGS_FILES))

help:
	@echo    "Доступни циљеви:"
	@echo -e "\tmake all\t\tизграђује све доступне формате"
	@echo -e "\tmake check\t\tпровера исправности појмовника"
	@echo -e "\tmake clean\t\tуклања генерисане датотеке"
	@echo -e "\tmake help\t\tиспис ове помоћи"
	@for a in $(DVG_SETTINGS_FILES); do make -s -f $$a help; done

all: check $(DVG_TARGETS)

check: 
	$(DGPROC) $(TOP_XML)

clean:
	$(RM) *~ $(DVG_TARGETS)

dvg-%: $(TOP_XML) $(DEPS)
	INCLUDEMAKE="Settings.$@" make -f Makefile.common common
