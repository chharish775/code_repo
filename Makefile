SOURCE_DIR:= .
BIN:=$(SOURCE_DIR)/bin
OBJECT_DIR:=$(BIN)
SOURCES:=$(wildcard $(SOURCE_DIR)/*.c)
OBJECT_FILES:=$(patsubst %.c, %.o, $(SOURCES))
EXEC_FILES:=$(patsubst %.o, %.a, $(OBJECT_FILES))
OBJECTS=$(addprefix $(OBJECT_DIR)/,$(OBJECT_FILES))
EXECS=$(addprefix $(OBJECT_DIR)/,$(EXEC_FILES))
#or you could do both steps above within a single assignment
#OBJECTS:=$(addprefix $(OBJECT_DIR)/,$(patsubst %.c, %.o, $(SOURCES)))
all: $(SOURCES) $(OBJECTS) $(EXECS)

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.c
	mkdir -p $(OBJECT_DIR)
	gcc -g -std=c99 -o $@ -c $<
	chmod 777 $(OBJECT_DIR)/*

$(OBJECT_DIR)/%.a: $(OBJECT_DIR)/%.o
	mkdir -p $(OBJECT_DIR)
	gcc -g -o $@ $< -lm

clean:
	rm -rf $(OBJECT_DIR)/*.o
	rm -rf $(OBJECT_DIR)/*.a
	rm -rf $(OBJECT_DIR)
