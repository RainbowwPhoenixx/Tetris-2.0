unit UTBoard;

interface
	
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTMatrix, UTNextPieces;
	
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
	
	// Other
	function isStateValid (matrix : TMatrix) : Boolean;
	function computeHardDropPos (matrix : TMatrix) : TTetrimino;
	procedure lockTetrimino (var matrix : TMatrix);
	procedure performHold (var board : Tboard);
	procedure handleEvent (var board : TBoard; movement : TMovement);
	function initBoard () : TBoard;
	
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
	
	// Other functions
	
	function initBoard () : TBoard;
	var 
		tmpBoard : TBoard;
		tmpQueue : TNextPieces;
		i : byte;
	begin
		setMatrix (tmpBoard, initMatrix (VOID));
		setHoldPiece (tmpBoard, VOID);
		
		// Initializing the next queue as empty
		tmpQueue := getNextQueue (tmpBoard);
		for i := 1 to Cnext_queue_length do
			setIthNextPiece (tmpQueue, i, VOID);
		setNextQueue (tmpBoard, tmpQueue);
		
		setScore (tmpBoard, 0);
		setLevel (tmpBoard, 0);
		
		initBoard := tmpBoard;
	end;
	
	// Checks wether the tetrimino has a valid position with the current minos in the matrix.
	function isStateValid (matrix : TMatrix) : Boolean;
	var
		i : byte;
		res : Boolean;
		tetri : TTetrimino;
		tmpMino : TMino;
	begin
		tetri := getActiveTetrimino (matrix);
		res := True;
		
		for i := 1 to 4 do
		begin
			tmpMino := getIthMino (tetri, i);
			
			// Check if the tetrimino occupies a space where a mino is already present.
			res := res and (isMinoEmpty (getMinoFromCoords (matrix, getMinoX (tmpMino), getMinoY(tmpMino))));
			
			// Check if the tetrimino is outside of the field (sides)
			res := res and (getMinoX (tmpMino) <= Cmatrix_width) and (getMinoX (tmpMino) >= 1);
			
			// Check if the tetrimino has hit the bottom
			res := res and (getMinoY (tmpMino) >= 1);
		end;
		isStateValid := res;
	end;
	
	function computeHardDropPos (matrix : TMatrix) : TTetrimino;
	var
		tmpMatrix : TMatrix;
		nextTetri, tetri : TTetrimino;
	begin
		nextTetri := getActiveTetrimino (matrix);
		repeat
			tetri := nextTetri;
			nextTetri := moveTetrimino (tetri, SD);
			setActiveTetrimino (tmpMatrix, nextTetri);
		until not isStateValid (tmpMatrix);
		
		computeHardDropPos := tetri;
	end;
	
	procedure lockTetrimino (var matrix : TMatrix);
	var
		tmpTetrimino : TTetrimino;
		tmpMino : TMino;
		i : byte;
	begin
		tmpTetrimino := getActiveTetrimino (matrix);
		for i := 1 to 4 do
		begin
			tmpMino := getIthMino (tmpTetrimino, i);
			setMinoAtCoords (matrix, getMinoX (tmpMino), getMinoY (tmpMino), tmpMino);
			// TODO set a flag to indicate a new tetrimino needs to be computed
		end;
	end;
	
	procedure performHold (var board : Tboard);
	var
		tmpHold : TShapeTetrimino;
		tmpMatrix : TMatrix;
	begin
		tmpHold := getHoldPiece (board);
		tmpMatrix := getMatrix (board);
		setHoldPiece (board, getTetriminoShape (getActiveTetrimino (tmpMatrix)));
		setActiveTetrimino (tmpMatrix, newTetrimino (tmpHold));
		setMatrix (board, tmpMatrix);
	end;
	
	procedure handleEvent (var board : TBoard; movement : TMovement);
	var
		tmpMatrix : TMatrix;
		tmpTetrimino : TTetrimino;
	begin
		tmpMatrix := getMatrix (board);
		
		case movement of // LFT, RGHT, SD, HD, CW, CCW, R180, HOLD
			LFT, RGHT, SD, CW, CCW, R180:
			begin
				tmpTetrimino := moveTetrimino (getActiveTetrimino (tmpMatrix), movement);
				setActiveTetrimino (tmpMatrix, tmpTetrimino);
				if isStateValid (tmpMatrix) then // If the game state is valid, then we apply the movement to the output variable.
					setMatrix (board, tmpMatrix);
			end;
			
			HD:
			begin
				setActiveTetrimino (tmpMatrix, computeHardDropPos (tmpMatrix));
				lockTetrimino (tmpMatrix);
			end;
			
			HOLD:
			begin
				performHold(board);
			end;
		end;
	end;
end.
