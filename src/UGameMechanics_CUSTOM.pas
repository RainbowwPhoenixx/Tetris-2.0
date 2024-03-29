unit UGameMechanics_CUSTOM;

interface

  uses  UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTMatrix, UTNextPieces, UTBoard, UTGeneralInterfaceTypes, crt;

  procedure runGame (IO : IO_Interface);
  procedure computeFrame(var board : TBoard; IO : IO_Interface);
  procedure computeTurn (var board : TBoard; IO : IO_Interface);

	function isStateValid (matrix : TMatrix) : Boolean;
	function computeHardDropPos (matrix : TMatrix) : TTetrimino;
	procedure lockTetrimino (var matrix : TMatrix);
	procedure handleEvent (var board : TBoard; movement : TMovement; IO : IO_Interface);
	function initBoard (shape : TShapeTetrimino) : TBoard;

implementation

  // The tetrimino movements depend on the version
  function moveTetrimino (t: TTetrimino; movement : TMovement) : TTetrimino;
  var
    tmpTetrimino : TTetrimino;
  begin
    tmpTetrimino := t;
    case movement of // L, R, SD, HD, CW, CCW, R180, HOLD
    LFT: begin
      tmpTetrimino := shiftTetrominoXAxis (t, '-');
       end;

    RGHT: begin
      tmpTetrimino := shiftTetrominoXAxis (t, '+');
       end;

    SD: begin
      tmpTetrimino := shiftTetrominoYAxis (t, '-');
       end;

    HD: begin
      // Not implemented yet. Hard drop depends on the minos inside of the matrix, it will probably not be implemented here.
       end;

    CW: begin
      tmpTetrimino := rotateTetrimino (t, '-90');
       end;

    CCW: begin
      tmpTetrimino := rotateTetrimino (t, '90');
       end;

    R180: begin
      tmpTetrimino := rotateTetrimino (t, '180');
       end;

    HOLD: begin
      // Basically same as HD
       end;
    NOTHING:;
    end;
  moveTetrimino := tmpTetrimino;
  end;

  procedure runGame (IO : IO_Interface);
  var
    board : Tboard;
  begin
    Randomize ();

    board := initBoard(getRandomShape ());

    IO.initOut();

    repeat
  		computeTurn (board, IO);
  	until getLostStatus (board);
  end;

  procedure checkLoss (var board : TBoard); // Sets the lost status to true is necesary
  var
    currentTetrimino : TTetrimino;
  begin
    // If the tetrimino hasn't moved before locking, then the game is lost.
    currentTetrimino := getActiveTetrimino (getMatrix (board));
    if areTetriminoIdentical(currentTetrimino, newTetrimino (getTetriminoShape (currentTetrimino))) then
      setLostStatus (board, True);
  end;

  procedure computeFrame(var board : TBoard; IO : IO_Interface);
  var
    move: TMovement;
  begin
    // Look for inputs from the player
    move := IO.PlayerIn ();
    // Apply those inputs to the board
    handleEvent (board, move, IO);
    // Display the board
    IO.BoardOut (board);
    // Wait some time for the next frame.
    delay (16); // ~60 fps
  end;

  function levelToSpeed (level : byte) : byte;
  begin
    // Transforms the current level into a number of frames before automatic descent of the tetrimino

    case level of
    	0: levelToSpeed := 48;
    	1: levelToSpeed := 43;
    	2: levelToSpeed := 38;
    	3: levelToSpeed := 33;
    	4: levelToSpeed := 28;
    	5: levelToSpeed := 23;
    	6: levelToSpeed := 18;
    	7: levelToSpeed := 13;
    	8: levelToSpeed := 8;
    	9: levelToSpeed := 6;
    	10, 11, 12: levelToSpeed := 5;
    	13, 14, 15: levelToSpeed := 4;
    	16, 17, 18: levelToSpeed := 3;
    	else levelToSpeed := 2;
    end;
  end;

  procedure clearLines (var matrix : TMatrix; var linesCleared : byte);
  var
    linesToClear : Array [1..4] of COORDINATE_TYPE;
    needsToBeCleared : Boolean;
    i, j : COORDINATE_TYPE;
    k : byte;
  begin
    // First detect which lines need to be cleared
    linesCleared := 0;
    for i := 1 to Cmatrix_visible_height do
    begin
      needsToBeCleared := True;
      // If one of the minos on the Ith line is VOID, then needsToBeCleared will be false
      for j := 1 to Cmatrix_width do
        needsToBeCleared := needsToBeCleared and (not isMinoEmpty(getMinoFromCoords (matrix, j, i)));

      if needsToBeCleared then
      begin
        linesCleared := linesCleared + 1;
        linesToClear[linesCleared] := i;
      end;
    end;

    // Then clear those lines
    if linesCleared > 0 then
      for i := 1 to linesCleared do
        for j := 1 to Cmatrix_width do
          setMinoAtCoords (matrix, j, linesToClear[i], newMino (j, linesToClear[i], VOID));

    // Then pull down all of the lines above the cleared lines
    for k := linesCleared downto 1 do
      for i := linesToClear[k] to Cmatrix_height - 1 do
        for j := 1 to Cmatrix_width do
          setMinoAtCoords (matrix, j, i, newMino(j, i, getMinoType(getMinoFromCoords(matrix, j, i + 1))));

  end;

  procedure updateScore (var board : TBoard; linesCleared : byte);
  var score : SCORE_TYPE;
  begin
    score := getScore (board);
    case linesCleared of
      1 : score := score + (getLevel (board) + 1) * 40;
      2 : score := score + (getLevel (board) + 1) * 100;
      3 : score := score + (getLevel (board) + 1) * 300;
      4 : score := score + (getLevel (board) + 1) * 1200;
    end;
    setScore (board, score);
  end;

  procedure updateLines (var board : TBoard; lines : byte);
  begin
    setLines (board, getLines (board) + lines);
  end;

  procedure updateLevel (var board : TBoard);
  begin
    if (getLines (board) div 10) > getLevel (board) then
      setLevel (board, getLevel(board) + 1);
  end;

  procedure initTurn (var board : TBoard; IO : IO_Interface);
  var
    mat : TMatrix;
    queue : TNextPieces;
  begin
    // Get the next item in queue
    mat := getMatrix (board);
    setActiveTetrimino (mat, newTetrimino (getIthNextPiece (getNextQueue (board), 1)));
    setMatrix (board, mat);

    // Advance the queue
    queue := getNextQueue (board);
    moveNextPiecesOneStep (queue);
    setIthNextPiece (queue, Cnext_queue_length, getRandomShape()); // Add a new piece in queue
    setNextQueue (board, queue);

    // Display game stats
    IO.ScoreOut (getScore (board));
    IO.LevelOut (getLevel (board));
    IO.LinesOut (getLines (board));
    IO.NextQueueOut (getNextQueue (board));

    // Reset held status
    setHasHeld(board, False);
  end;

  procedure endTurnWrapper (var board : TBoard);
  var
    linesCleared : byte;
    tmpMat : TMatrix;
  begin
    // Clear lines
    tmpMat := getMatrix (board);
    clearLines (tmpMat, linesCleared);
    setMatrix (board, tmpMat);

    // Update score
    updateScore (board, linesCleared);
    // Update lines cleared
    updateLines (board, linesCleared);
    // Update level TODO
    updateLevel (board);
  end;

  procedure computeTurn (var board : TBoard; IO : IO_Interface);
  var
    currentFrameNb : byte;
    currentSpeed : byte;
  begin
    initTurn (board, IO);

    currentFrameNb := 0;
    currentSpeed := levelToSpeed (getLevel (board));
    repeat
      computeFrame (board, IO);

      // Automatic descent
      if currentFrameNb > currentSpeed then
      begin
        handleEvent (board, SD, IO);
        currentFrameNb := 0;
      end
      else
        currentFrameNb := currentFrameNb + 1;
    until getEndTurn (board);
    setEndTurn (board, False);

    checkLoss (board);

    // Clears lines & update score
    endTurnWrapper (board);
  end;

  function initBoard (shape : TShapeTetrimino) : TBoard;
	var
		tmpBoard : TBoard;
		tmpQueue : TNextPieces;
		i : byte;
	begin
		setMatrix (tmpBoard, initMatrix (shape));
		setHoldPiece (tmpBoard, VOID);

    // Init the queue with random pieces
    tmpQueue := getNextQueue (tmpBoard);
    for i := 1 to Cnext_queue_length do
    begin
      setIthNextPiece (tmpQueue, i , getRandomShape());
    end;
    setNextQueue (tmpBoard, tmpQueue);

		setScore (tmpBoard, 0);
		setLevel (tmpBoard, 0);
    setLostStatus (tmpBoard, False);
    setEndTurn (tmpBoard, False);

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

			// Check if the tetrimino is outside of the field (sides)
			res := res and (getMinoX (tmpMino) <= Cmatrix_width) and (getMinoX (tmpMino) >= 1);

			// Check if the tetrimino has hit the bottom
			res := res and (getMinoY (tmpMino) >= 1);

			// Check if the tetrimino occupies a space where a mino is already present.
			res := res and (isMinoEmpty (getMinoFromCoords (matrix, getMinoX (tmpMino), getMinoY(tmpMino))));

		end;
		isStateValid := res;
	end;

	function computeHardDropPos (matrix : TMatrix) : TTetrimino; // Should be deleted, doesn't exist in classic tetris
	var
		tmpMatrix : TMatrix;
		nextTetri, tetri : TTetrimino;
	begin
		tmpMatrix := matrix;
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
		end;
	end;

	procedure performHold (var board : Tboard; IO : IO_Interface);
	var
		tmpHold : TShapeTetrimino;
		tmpMatrix : TMatrix;
	begin
    if not getHasHeld (board) then
    begin
  		tmpHold := getHoldPiece (board);
  		tmpMatrix := getMatrix (board);
  		setHoldPiece (board, getTetriminoShape (getActiveTetrimino (tmpMatrix)));
  		setActiveTetrimino (tmpMatrix, newTetrimino (tmpHold));
  		setMatrix (board, tmpMatrix);
      if tmpHold = VOID then
        initTurn (board, IO); // If the hold was void, override current piece with piece from next queue
      setHasHeld (board, True);
    end;
	end;

	procedure handleEvent (var board : TBoard; movement : TMovement; IO : IO_Interface);
	var
		tmpMatrix : TMatrix;
		tmpTetrimino : TTetrimino;
	begin
		tmpMatrix := getMatrix (board);

		case movement of // LFT, RGHT, SD, HD, CW, CCW, R180, HOLD
			LFT, RGHT, CW, CCW, R180:
			begin
				tmpTetrimino := moveTetrimino (getActiveTetrimino (tmpMatrix), movement);
				setActiveTetrimino (tmpMatrix, tmpTetrimino);
				if isStateValid (tmpMatrix) then // If the game state is valid, then we apply the movement to the output variable.
					setMatrix (board, tmpMatrix);
			end;

      SD:
      begin
        tmpTetrimino := moveTetrimino (getActiveTetrimino (tmpMatrix), movement);
        setActiveTetrimino (tmpMatrix, tmpTetrimino);
        if isStateValid (tmpMatrix) then // If the game state is valid, then we apply the movement to the output variable.
          setMatrix (board, tmpMatrix)
        else // If not, it means the piece should be locked (without the change to the tetrimino)
        begin
          tmpMatrix := getMatrix (board);
          lockTetrimino (tmpMatrix);
          setEndTurn (board, True); // Should be wrapped inside lockTetrimino
  				setMatrix (board, tmpMatrix);
        end;
      end;

			HD:
			begin
				setActiveTetrimino (tmpMatrix, computeHardDropPos (tmpMatrix));
				lockTetrimino (tmpMatrix);
        setEndTurn (board, True); // Should be wrapped inside lockTetrimino
        setMatrix (board, tmpMatrix);
			end;

			HOLD:
			begin
				performHold(board, IO);
        IO.HoldOut (getHoldPiece (board));
			end;
		end;
	end;
end.
