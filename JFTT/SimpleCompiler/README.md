# Compiler of simple imperative language 
gramar is present in src/gramatyka.txt

1. [Using](#using)
 * [Installation](#installation)
 * [Compiling programs](#compiling-programs)
2. [Requirements](#requirements)
3. [Files description](#files-description)

## Using
### Installation:

	make

### Compiling programs

#### To run your program in this language WITH cln library interpreter:

	make tester_cln SRC=src_to_program/program.imp

##### Example:

	make tester_cln SRC = test/program0.imp
	
It will compile program0.imp and run it with interpreter-cln

#### To test your program in this language WITHOUT cln library interpreter:

	make tester SRC=src_to_program/program_name.imp
	
##### Example:

	make tester SRC = test/program0.imp

It will compile program0.imp and run it with interpreter
  
#### To test program which is named programX.imp and is in `test` directory:

	make mytest NO=X
    
##### Example:
	
	make mytest NO=1

It will compile program1.imp from test directory and run it with interpreter-cln
		
		
				
## Requirements

flex 2.6.0
bison  3.0.4
gcc 5.4.0
g++ 5.4.0
Or some newer compatible with them.



## Files description
```
.
├── Makefile
├── README
├── src
│   ├── command_list.c
│   │   	Part of code responsible for compiler output code.
│   │
│   ├── gramatyka.txt
│   │   	Gramar of simple compiler.
│   │
│   ├── imp.flex
│   │	  	Flex scanner file.
│   │
│   ├── imp.y
│   │		Bison file that analyze code.
│   │
│   ├── jump_list.c
│   │		Part of code responsible for complete jumps.
│   │
│   ├── registers.c
│   │		Dumb register handler.
│   │
│   ├── variable_list.c
│   │		Part of code responsible for finding, initializing and declaring variables.
│   └
├── test
│   │		Folder for tests and programs.
│   │
│   ├── program0.imp
│   ├── program1.imp
│   ├── program2.imp
│   ├── program3.imp
│   ├── program4.imp
│   ├── program5.imp
│   ├── program6.imp
│   └── program7.imp
└── tests.ods
```
