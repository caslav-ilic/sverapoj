# -*- Makefile -*-
# Аутоматизација изградње појмовника.  
# Идеално, комплетан појмовник, у свим форматима, треба да се добије
# куцањем само једне наредбе у командној линији.

DGPROC:=dgproc.py
SR_LOCALE:=sr_RS.UTF-8

.PHONY: help html check

help:
	@echo    "Доступни циљеви:"
	@echo -e "\tmake help\t\tиспис ове помоћи"
	@echo -e "\tmake html\t\tизградња појмовника у ХТМЛу"
	@echo -e "\t\t\t\t(потребно је да је инсталиран dgproc.py)"

html: 
	LC_ALL=$(SR_LOCALE) $(DGPROC) html top.xml -sbase:html

check: 
	$(DGPROC) top.xml
