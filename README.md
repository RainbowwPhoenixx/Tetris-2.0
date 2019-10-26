# Tetris-2.0
Repo for my tetris clone

This project consists in writing a tetris clone with a vs mode, to eventually develop an AI.
I have decided to put this project into something somewhat coherent and then port it to the C language. Link to the C repository will appear here when development begins. As of now, the vs part is no longer planned for this project, and neither is the AI. The Pascal language is no longer satisfactory. These features will probably come back during the port to C.

## How to install ?

- Make sure the FreePascal Compiler (fpc) is installed. If it is not you can install it with `sudo apt install fpc` on Debian.

- Go into the Tetris-2.0 and execute the compiling script with `./compile.sh`. It should create the bin directory and create a bunch of files into it. The program is now installed and compiled properly assuming you didn't get any error message during compilation.

## How to play ?
 Simply execute the execution script, with `./execute.sh`. The game should launch in the terminal.

## Features to come (in no specific order)
- Holding only once per piece
- Rework of the input, to add proper DAS
- Separating modern and classic gamemodes
- Menus !
- Configurable keys
- The ability to pause
- Graphical interface before the C port if I feel like it
