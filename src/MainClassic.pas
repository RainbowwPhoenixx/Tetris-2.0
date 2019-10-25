program MainClassic.pas;

uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTNextPieces, UTGeneralInterfaceTypes, UTerminalInterface, UTBoard, UGameMechanics_CLASSIC;

var
	board : Tboard;
	IO : IO_Interface;
	i : byte;
	tmpNextQueue : TNextPieces;

begin
	Randomize ();

	board := initBoard(getRandomShape ());

	// Init the queue with random pieces
	for i := 1 to Cnext_queue_length do
	begin
		tmpNextQueue := getNextQueue (board);
		setIthNextPiece (tmpNextQueue, i , getRandomShape());
		setNextQueue (board, tmpNextQueue);
	end;

	initializeDisplay ();

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

	repeat
		computeTurn (board, IO);
	until getLostStatus (board);
end.
