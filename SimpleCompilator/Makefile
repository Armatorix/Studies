CC=gcc
CPP=g++
CPPFLAGS=-Wall -std=c++11
BFLAGS=-d -b bin/imp
CFLAGS=-lfl -lm -I src/ 
FFLAGS=-o bin/lex.yy.c
all:  bison interpreter
	flex $(FFLAGS) src/imp.flex 
	$(CC)  bin/lex.yy.c bin/imp.tab.c $(CFLAGS) -o bin/out
	make clean_part
	clear
	@echo "Done."
interpreter:
	$(CPP) $(CPPFLAGS) src/interpreter.cc -o bin/interpreter
	$(CPP) $(CPPFLAGS) src/interpreter-cln.cc -l cln -o bin/interpreter-cln
bison:
	bison $(BFLAGS) src/imp.y
clean:
	rm bin/*
clean_part:
	rm bin/imp.tab.c bin/imp.tab.h bin/lex.yy.c
tester:
	./bin/out bin/kod < $(SRC)
	./bin/interpreter bin/kod
tester_cln:
	./bin/out bin/kod < $(SRC)
	./bin/interpreter-cln bin/kod
mytest:
	./bin/out bin/kod < test/program$(NO).imp
	./bin/interpreter-cln bin/kod
