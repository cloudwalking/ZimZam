CC = gcc
CFLAGS = 
LD = gcc
LDFLAGS = 
SHELL = /bin/sh

all: main Car Calendar Entry
	$(LD) $(LDFLAGS) Car.o Calendar.o Entry.o main.o -framework Foundation

Car: Car.m 
	$(CC) $(CFLAGS) Car.m -c -o Car.o

Calendar: Calendar.m
	$(CC) $(CFLAGS) Calendar.m -c -o Calendar.o

Entry: Entry.m
	$(CC) $(CFLAGS) Entry.m -c -o Entry.o

main: main.m
	$(CC) $(CFLAGS) main.m -c -o main.o
