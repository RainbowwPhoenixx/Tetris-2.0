mkdir bin

echo "----- Compiling type units -----"

fpc "src/UConstants.pas" -FE"./bin/"
echo "
"
fpc "src/UTShape.pas" -FE"./bin/"
echo "
"
fpc "src/UTMino.pas" -FE"./bin/"
echo "
"
fpc "src/UTTetrimino.pas" -FE"./bin/"



#fpc "src/" -FE"../bin/"
