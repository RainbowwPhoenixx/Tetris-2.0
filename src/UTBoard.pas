unit UTBoard;

interface
	
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTGeneralInterfaceTypes, UTerminalInterface;
	
	
	Type TMatrix = Array [1..Cmatrix_width,1..Cmatrix_height] of TMino;
	Type TNextPieces = Array [1..Cnext_queue_length] of TShapeTetrimino;
	
	Type TBoard = record
		holdPiece : TShapeTetrimino;
		matrix : TMatrix;
		nextQueue : TNextPieces;
		
		level : byte;
		score : SCORE_TYPE;
	end;
	
	// Accessors for TBoard
	function getHoldPiece (board : TBoard) : TShapeTetrimino;
	procedure setHoldPiece (var board : TBoard; shape : TShapeTetrimino);
	
	function getMatrix (board : TBoard) : TMatrix;
	procedure setMatrix (var board : TBoard; mat : TMatrix);
	
	function getNextQueue (board : TBoard) : TNextPieces;
	procedure setNextQueue (var board : TBoard; nextPieces : TNextPieces);
	
	function getLevel (board : TBoard) : byte;
	procedure setLevel (var board : TBoard; level : byte);
	
	function getScore (board : TBoard) : SCORE_TYPE;
	procedure setScore (var board : TBoard; score : SCORE_TYPE);
	
	// Accessors for TMatrix
	function getMinoFromCoords (matrix : TMatrix; x, y : COORDINATE_TYPE) : TMino;
	procedure setMinoAtCoords (var matrix : TMatrix; x, y : COORDINATE_TYPE; mino : TMino);
	
	// Accessors for TNextPieces
	function getIthNextPiece (nextQueue : TNextPieces; i : byte) : TShapeTetrimino;
	procedure setIthNextPiece (var nextQueue : TNextPieces; i : byte; piece : TShapeTetrimino);
	
implementation
	
	// Accessors for TBoard
	function getHoldPiece (board : TBoard) : TShapeTetrimino;
	begin
		getHoldPiece := board.holdPiece;
	end;
	
	procedure setHoldPiece (var board : TBoard; shape : TShapeTetrimino);
	begin
		board.holdPiece := shape;
	end;
	
	function getMatrix (board : TBoard) : TMatrix;
	begin
		getMatrix := board.matrix;
	end;
	
	procedure setMatrix (var board : TBoard; mat : TMatrix);
	begin
		board.matrix := mat;
	end;
	
	function getNextQueue (board : TBoard) : TNextPieces;
	begin
		getNextQueue := board.nextQueue;
	end;
	procedure setNextQueue (var board : TBoard; nextPieces : TNextPieces);
	begin
		board.nextQueue := nextPieces;
	end;
	
	function getLevel (board : TBoard) : byte;
	begin
		getLevel := board.level;
	end;
	
	procedure setLevel (var board : TBoard; level : byte);
	begin
		board.level := level;
	end;
	
	function getScore (board : TBoard) : SCORE_TYPE;
	begin
		getScore := board.score;
	end;
	
	procedure setScore (var board : TBoard; score : SCORE_TYPE);
	begin
		board.score := score;
	end;
	// Accessors for TMatrix
	function getMinoFromCoords (matrix : TMatrix; x, y : COORDINATE_TYPE) : TMino;
	begin
		getMinoFromCoords := matrix[x][y];
	end;
	
	procedure setMinoAtCoords (var matrix : TMatrix; x, y : COORDINATE_TYPE; mino : TMino);
	begin
		matrix[x][y] := mino;
	end;
	
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
