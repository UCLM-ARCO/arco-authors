
include arco/build.mk

PROJECT_NAME = $(notdir $(PROJECT_DIR))
TARGETS_DIR = $(PROJECT_DIR)/slice/$(PROJECT_NAME)
LIB_FULLNAME = $(TARGETS_DIR)/lib$(PROJECT_NAME)Slice.la

SLICES ?= $(wildcard *.ice)
SLICE_GEN = $(SLICES:%.ice=%.cpp)
SLICE_OBJ = $(addprefix $(TARGETS_DIR)/,$(SLICES:%.ice=%.o))

CC = $(CXX)
CXXFLAGS += -I. -I$(TARGETS_DIR)

SLICE_FLAGS = -I /usr/share/Ice/slice --output-dir=$(TARGETS_DIR)

all: $(TARGETS_DIR) $(LIB_FULLNAME) 

$(TARGETS_DIR):
	mkdir -p $@

$(LIB_FULLNAME): $(SLICE_OBJ) 
	ld -Ur -o $@ $^

$(TARGETS_DIR)/%.cpp: %.ice
	slice2cpp $(SLICE_FLAGS) $<

.PHONY: clean
clean:
	$(RM) -rf $(TARGETS_DIR) 

install: all
	install -dv $(DESTDIR)/usr/lib/
	install -dv $(DESTDIR)/usr/include/$(PROJECT_NAME)
	install -m 644 $(LIB_FULLNAME) $(DESTDIR)/usr/lib/
	install -vm 644 $(TARGETS_DIR)/*.h $(DESTDIR)/usr/include/$(PROJECT_NAME)





