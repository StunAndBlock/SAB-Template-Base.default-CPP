## <os agnostic>
ifeq ($(OS),Windows_NT)
	EXECUTABLE_PREFIX = exe
else
	UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        EXECUTABLE_PREFIX = out
    endif
endif

## !<>

## <compiller>
CC = g++
## !<>

## <name of binary>
TARGET = name.$(EXECUTABLE_PREFIX)
## !<>

## <dir-realted variables>
BUILD_DIR = build
INCLUDE_DIR = include
INCLUDE_PATH = $(INCLUDE_DIR)/
SRC_DIR = src
SRC_PATH = $(SRC_DIR)/
## !<>

## <flag-related>
CFLAGS = -std=c++17 \
         -O0 -D_FORTIFY_SOURCE=2 -fstack-protector \
		 -Wall -Wextra -Werror -Wshadow \
		
LDFLAGS = 

## !<>

## <modular system>
MMAIN = main.cpp
 
MODULES = $(MMAIN)
#### DO NOT TOUCH
CPP = $(addprefix $(SRC_PATH),$(filter %.cpp,$(MODULES)))
HEADERS = $(addprefix $(INCLUDE_PATH),$(filter %.hpp %.h,$(MODULES)))
OBJECTS = $(patsubst %.cpp,%.o,$(CPP))
## !<>


## <Make main system>
.PHONY: all clean build

all: build

build: $(OBJECTS) | $(BUILD_DIR)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $(BUILD_DIR)/$(TARGET)  

### do not touch dynamic object compilation
$(OBJECTS): %.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS)
	rm -rf $(BUILD_DIR)

### build dir ensurance
$(BUILD_DIR):
	mkdir -p  $(BUILD_DIR)


# !<>