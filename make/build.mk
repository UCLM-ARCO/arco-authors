
SHELL = /bin/bash

PARENT := $(dir $(lastword $(MAKEFILE_LIST)))
PROJECT_DIR = $(shell $(PARENT)/../bin/arco-get-project-dir.sh)

PROJECT_LIBDIR := $(PROJECT_DIR)/lib
PROJECT_BINDIR := $(PROJECT_DIR)/bin
PROJECT_INCLUDEDIR := $(PROJECT_DIR)/include

LDFLAGS    += -L$(PROJECT_LIBDIR)
CXXFLAGS   += -I$(PROJECT_INCLUDEDIR)
CFLAGS     += -I$(PROJECT_INCLUDEDIR)


all:
	echo $(PROJECT_DIR)
