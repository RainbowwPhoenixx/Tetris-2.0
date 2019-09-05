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
	
end.
