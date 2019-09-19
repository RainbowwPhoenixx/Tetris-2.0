unit UTBoard;

interface

	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTMatrix, UTNextPieces;

	Type TBoard = record
		holdPiece : TShapeTetrimino;
		matrix : TMatrix;
		nextQueue : TNextPieces;

		DASCounter : byte; //Unused for now
		frameCounter : word; // Unused for now
		comboCounter : byte; //Unused for now
		backToBack : Boolean; //Unused for now
		endTurn : Boolean;

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

end.
