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
		lost : Boolean;
		hasHeldThisTurn : Boolean;

		level : byte;
		score : SCORE_TYPE;
		lines : byte; // Contains the number of cleared lines
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

	function getDAS (board : TBoard) : byte;
	procedure setDAS (var board : TBoard; DAS : byte);

	function getFrameNb (board : TBoard) : word;
	procedure setFrameNb (var board : TBoard; frameNb : word); // This will probably never be used

	function getCombo (board : TBoard) : byte;
	procedure setCombo (var board : TBoard; comboNb : byte);

	function getBackToBackStatus (board : TBoard) : Boolean;
	procedure setBackToBackStatus (var board : TBoard; b2b : Boolean);

	function getEndTurn (board : TBoard) : Boolean;
	procedure setEndTurn (var board : TBoard; shouldBeEnded : Boolean);

	function getLostStatus (board : TBoard) : Boolean;
	procedure setLostStatus (var board : TBoard; lostStatus : Boolean);

	function getLines (board : TBoard) : byte;
	procedure setLines (var board : TBoard; linesCleared : byte);

	function getHasHeld (board : TBoard) : Boolean;
	procedure setHasHeld (var board : TBoard; held : Boolean);

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

	function getDAS (board : TBoard) : byte;
	begin
		getDAS := board.DASCounter;
	end;

	procedure setDAS (var board : TBoard; DAS : byte);
	begin
		board.DASCounter := DAS;
	end;

	function getFrameNb (board : TBoard) : word;
	begin
		getFrameNb := board.frameCounter;
	end;

	procedure setFrameNb (var board : TBoard; frameNb : word); // This will probably never be used
	begin
		board.frameCounter := frameNb;
	end;

	function getCombo (board : TBoard) : byte;
	begin
		getCombo := board.comboCounter;
	end;

	procedure setCombo (var board : TBoard; comboNb : byte);
	begin
		board.comboCounter := comboNb;
	end;

	function getBackToBackStatus (board : TBoard) : Boolean;
	begin
		getBackToBackStatus := board.backToBack;
	end;

	procedure setBackToBackStatus (var board : TBoard; b2b : Boolean);
	begin
		board.backToBack := b2b;
	end;

	function getEndTurn (board : TBoard) : Boolean;
	begin
		getEndTurn := board.endTurn;
	end;

	procedure setEndTurn (var board : TBoard; shouldBeEnded : Boolean);
	begin
		board.endTurn := shouldBeEnded;
	end;

	function getLostStatus (board : TBoard) : Boolean;
	begin
		getLostStatus := board.lost;
	end;

	procedure setLostStatus (var board : TBoard; lostStatus : Boolean);
	begin
		board.lost := lostStatus;
	end;

	function getLines (board : TBoard) : byte;
	begin
		getLines := board.lines;
	end;

	procedure setLines (var board : TBoard; linesCleared : byte);
	begin
		board.lines := linesCleared;
	end;

	function getHasHeld (board : TBoard) : Boolean;
	begin
		getHasHeld := board.hasHeldThisTurn;
	end;

	procedure setHasHeld (var board : TBoard; held : Boolean);
	begin
		board.hasHeldThisTurn := held;
	end;

end.
