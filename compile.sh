constants_files=("src/UConstants.pas")
type_unit_files=("src/UTShape.pas src/UTMino.pas src/UTTetrimino.pas src/UTMovement.pas src/UTMatrix.pas src/UTNextPieces.pas src/UTBoard.pas src/UTGeneralInterfaceTypes.pas")

interface_unit_files=("src/UTerminalInterface.pas")

compile_file () { #Compiles the given file and formats the output
	fpc $1 -FE"./bin/" | tail -n +4 | egrep --color=always 'Warning|Fatal|$' | GREP_COLOR='0;32' egrep --color=always 'compiled|$'
	echo ""
}

mkdir bin

echo "----- Compiling constants units -----"
for file_ in $constants_files
do
    compile_file $file_
done

echo "----- Compiling type units -----"
for file_ in $type_unit_files
do
    compile_file $file_
done

echo "----- Compiling inteface units -----"
for file_ in $interface_unit_files
do
    compile_file $file_
done

echo 'Done'
#fpc "src/" -FE"../bin/"
