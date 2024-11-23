CC = gcc
# gnu99 instead of c99 for the struct timespec
CFLAGS = -std=gnu99 -Wall -Werror -Wextra -pedantic
IFLAGS = 
LFLAGS = -lm

OBJS = pocketfft.o

all: test pocketfft.o

.c.o:
	$(CC) $(CFLAGS) $(IFLAGS) -O2 $< -o $@ $(LFLAGS)

test:
	if [ -n "$(SANITIZE)" ] ; then export DBGOPT="-fsanitize=address,undefined";  else export DBGOPT="" ; fi ; \
	$(CC) $(CFLAGS) $$DBGOPT $(IFLAGS) -g -O0 *.c -o test $(LFLAGS)

check: test
	./test
	
clean:
	rm -f *.o test