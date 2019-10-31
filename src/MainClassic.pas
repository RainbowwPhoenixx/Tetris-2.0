program MainClassic.pas;

uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTNextPieces, UTGeneralInterfaceTypes, UTerminalInterface, UTBoard, UGameMechanics_CUSTOM;

var
	IO : IO_Interface;
begin

	IO := newInterface (@initializeDisplay,
										  @clearScreen,
										  @clearMatrix,
										  @showMatrix,
										  @showTetrimino,
										  @showNextQueue,
										  @showHoldPiece,
										  @showBoard,
										  @showScore,
										  @showLevel,
											@showLines,
										  @getPlayerInput);

	runGame (IO);
end.
