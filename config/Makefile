.EXPORT_ALL_VARIABLES:
SHELL := /bin/bash
MAKE_TASKS := \
	install

# tasks with folder names need to be declared as phony
.PHONY: tests build

$(MAKE_TASKS):
	$@.sh

.DEFAULT:
	make -f Makefile.local "$@"
