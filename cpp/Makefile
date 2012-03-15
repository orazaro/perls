#$Id: Makefile,v 1.2 2010/08/23 10:46:23 oraz Exp $

CPP 			= $(wildcard *.cpp)
PROGRAMS	= $(CPP:%.cpp=%) 
CFILES 			= $(wildcard *.c)
PROGRAMC	= $(CFILES:%.c=%) 
LIBRARIES	= 

CC			= gcc
CXX			= g++
CFLAGS		+= -Wall -O3
CPPFLAGS		+= -Wall -O2
LDFLAGS		= $(LIBRARIES:%=-l%)

.PHONY: all clean

all: $(PROGRAMS) $(PROGRAMC) 

%: %.cpp
	$(CXX) $(CPPFLAGS) $^ -o $@

%: %.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f *.o *.a $(PROGRAMS) $(PROGRAMC)

