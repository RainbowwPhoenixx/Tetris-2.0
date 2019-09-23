unit UTNextPieces;

interface

	uses UConstants, UTShape, UTMino, UTTetrimino;

	Type TNextPieces = Array [1..Cnext_queue_length] of TShapeTetrimino;

	// Accessors for TNextPieces
	function getIthNextPiece (nextQueue : TNextPieces; i : byte) : TShapeTetrimino;
	procedure setIthNextPiece (var nextQueue : TNextPieces; i : byte; piece : TShapeTetrimino);


implementation

	// Accessors for TNextPieces
	function getIthNextPiece (nextQueue : TNextPieces; i : byte) : TShapeTetrimino;
	begin
		getIthNextPiece := nextQueue[i];
	end;

	procedure setIthNextPiece (var nextQueue : TNextPieces; i : byte; piece : TShapeTetrimino);
	begin
		nextQueue[i] := piece;
	end;

	// Useful functions
	procedure initNextPieces ();
	var
		queue : TNextPieces;
		i : byte;
	begin
		for i := 1 to Cnext_queue_length do
			setIthNextPiece	(queue, i, VOID);
	end;

	procedure moveNextPiecesOneStep (nextQueue : TNextPieces);
	var
		i : byte;
	begin
		// Move each next piece up the queue, the first one is lost
		for i := 1 to Cnext_queue_length - 1 do
			setIthNextPiece	(nextQueue, i, getIthNextPiece(nextQueue, i+1));
		// Set the last piece to empty
		setIthNextPiece (nextQueue, Cnext_queue_length, VOID);
	end;

end.
