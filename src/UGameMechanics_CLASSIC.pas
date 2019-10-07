UNIT UGameMechanics_CLASSIC;

INTERFACE

  USES  UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTMatrix, UTNextPieces, UTBoard, UTGeneralInterfaceTypes, crt;

  PROCEDURE computeFrame(var board : TBoard; IO : IO_Interface);

	function isStateValid (matrix : TMatrix) : Boolean;
	function computeHardDropPos (matrix : TMatrix) : TTetrimino;
	procedure lockTetrimino (var matrix : TMatrix);
	procedure performHold (var board : Tboard);
	procedure handleEvent (var board : TBoard; movement : TMovement);
	function initBoard (shape : TShapeTetrimino) : TBoard;

IMPLEMENTATION

  PROCEDURE computeFrame(var board : TBoard; IO : IO_Interface);
  var
    move: TMovement;
  BEGIN
    // Look for inputs from the player
    move := IO.PlayerIn ();
    // Apply those inputs to the board
    handleEvent (board, move);
    // Display the board
    IO.BoardOut (board);
    // Wait some time for the next frame.
    delay (100);
  END;

  procedure computeTurn (board : TBoard; IO : IO_Interface);
  begin

  end;

  function initBoard (shape : TShapeTetrimino) : TBoard;
	var
		tmpBoard : TBoard;
		tmpQueue : TNextPieces;
		i : byte;
	begin
		setMatrix (tmpBoard, initMatrix (shape));
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

			// Check if the tetrimino is outside of the field (sides)
			res := res and (getMinoX (tmpMino) <= Cmatrix_width) and (getMinoX (tmpMino) >= 1);

			// Check if the tetrimino has hit the bottom
			res := res and (getMinoY (tmpMino) >= 1);

			// Check if the tetrimino occupies a space where a mino is already present.
			res := res and (isMinoEmpty (getMinoFromCoords (matrix, getMinoX (tmpMino), getMinoY(tmpMino))));

		end;
		isStateValid := res;
	end;

	function computeHardDropPos (matrix : TMatrix) : TTetrimino;
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
		//This action shouldn't be performed here
		setActiveTetrimino (matrix, newTetrimino (getRandomShape ()));
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
				setMatrix (board, tmpMatrix);
			end;

			HOLD:
			begin
				performHold(board);
			end;
		end;
	end;
END.