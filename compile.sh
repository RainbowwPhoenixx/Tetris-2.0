mkdir bin

fpc "src/UConstants.pas" -FE"./bin/"
fpc "src/UTShape.pas" -FE"./bin/"
fpc "src/UTMino.pas" -FE"./bin/"
fpc "src/UTTetromino.pas" -FE"./bin/"



#fpc "src/" -FE"../bin/"
