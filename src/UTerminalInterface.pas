unit UTerminalInterface;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMatrix, UTBoard, UTNextPieces, UTMovement, UTGeneralInterfaceTypes, UConstantsTerminalInterface, // Imports of custum units
		crt, keyboard; // Imports of default units

	procedure initializeDisplay ();
	procedure clearScreen();
	procedure clearMatrix ();
	procedure showMatrix (matrix : TMatrix);
	procedure showTetrimino (t : TTetrimino);
	procedure showNextQueue (nextQueue : TNextPieces);
	procedure showHoldPiece (piece : TShapeTetrimino);
	procedure showBoard (board : TBoard);
	procedure showScore (score : SCORE_TYPE);
	procedure showLevel (level : byte);
	procedure showLines (lines : byte);
	procedure showSkin ();

	function getPlayerInput () : TMovement;

implementation

	function getColor (shape : TShapeTetrimino) : Shortint;
	begin
		case shape of
			VOID : getColor := Black;
			I : getColor := Cyan;
			J : getColor := LightGray;
			L : getColor := Blue;
			S : getColor := Red;
			Z : getColor := Green;
			O : getColor := Yellow;
			T : getColor := Magenta;
			else getColor := Blue;
		end;
	end;

	procedure showMino (mino : TMino; writeVoids : Boolean; offset_x, offset_y : byte);
	begin
		if (getMinoY (mino) < Cmatrix_visible_height + 1) then //Display the mino only if it is in the visible part of the matrix.
			if (not isMinoEmpty(mino) or writeVoids) then
			begin
				GotoXY (offset_x + (2 * getMinoX(mino)), offset_y - getMinoY(mino) + 1);
				TextBackground(getColor (getMinoType (mino)));
				Write('  ');
				TextBackground(Black);
			end;
	end;

	procedure initializeDisplay ();
	begin
		ClrScr;
		showSkin();
	end;

	procedure showMatrix (matrix : TMatrix);
	var
		i, j : COORDINATE_TYPE;
	begin
		for i := 1 to Cmatrix_visible_width do
			for j := 1 to Cmatrix_visible_height do
				showMino (getMinoFromCoords (matrix, i, j), True, Cmatrix_display_x, Cmatrix_display_y);
	end;

	procedure showNextQueue (nextQueue : TNextPieces);
	var
		i, j : byte;
		tmpTetrimino : TTetrimino;
	begin
		// First clear the area where the bolcks will show
		for i := Cnext_pieces_real_display_y to 23 do
		begin
			GotoXY(Cnext_pieces_real_display_x, i);
			write ('          ');
		end;

		// Then display the next pieces
		for i := 1 to Cvisible_next_queue_length do
		begin
			tmpTetrimino := newTetrimino (getIthNextPiece (nextQueue, i));
			for j := 1 to 4 do
				showMino (getIthMino (tmpTetrimino, j), False, Cnext_pieces_display_x, Cnext_pieces_display_y + 3*(i-1));
		end;
	end;

	procedure showHoldPiece (piece : TShapeTetrimino);
	var
		i : byte;
		tmpTetrimino : TTetrimino;
	begin
		if piece <> VOID then
		begin
			// First clear the area where it will show
			for i := Chold_real_display_y to Chold_real_display_y + 1 do
			begin
				GotoXY(Chold_real_display_x, i);
				write ('        ');
			end;

			// Then display yhe mino in Hold
			tmpTetrimino := newTetrimino (piece);
			for i := 1 to 4 do
				showMino (getIthMino (tmpTetrimino, i), False, Chold_display_x, Chold_display_y);
		end;
	end;

	procedure showScore (score : SCORE_TYPE);
	begin
		GotoXY(Cscore_display_x, Cscore_display_y);
		write (score);
	end;

	procedure showLevel (level : byte);
	begin
		GotoXY(Clevel_display_x, Clevel_display_y);
		write (level);
	end;

	procedure showLines (lines : byte);
	begin
		GotoXY(Clines_display_x, Clines_display_y);
		write (lines);
	end;

	procedure showTetrimino (t : TTetrimino);
	var i : byte;
	begin
		for i := 1 to 4 do
			showMino (getIthMino (t, i), False, Cmatrix_display_x, Cmatrix_display_y);
	end;

	procedure showSkin ();
	var
		line : String;
		skin : Text;
	begin
		assign(skin, BACKGROUND_PATH);
		reset(skin);
		GotoXY(1,1);
		while not (eof(skin)) do
			begin
				readln (skin, line); //Lit le fichier ligne par ligne et l'affiche
				writeln (line);
			end;
		close(skin);
	end;

	procedure clearMatrix ();
	var
		i : COORDINATE_TYPE;
	begin
		for i := 1 to Cmatrix_visible_height do
		begin
			GotoXY (Cmatrix_display_x + 1, Cmatrix_display_y - i);
			write ('                    ');
		end;
	end;

	procedure showBoard (board : TBoard);
	begin
		// Show the minos in the matrix
		showMatrix (getMatrix(board));

		// Then show the active tetrimino
		showTetrimino (getActiveTetrimino (getMatrix (board)));

		GotoXY (60,1); // Get the blinking cursor out of the way
	end;

	procedure clearScreen();
	var
		i : byte;
	begin
		GotoXY(1, 1);
		for i := 1 to 23 do
			writeln ('                                                                               ');
	end;

	function getPlayerInput () : TMovement;
	var
		key : TKeyEvent;
		K : String;
	begin
		InitKeyboard;

		key := PollKeyEvent;
		getPLayerInput := NOTHING;

		if key <> 0 then
		begin
			K := KeyEventToString(TranslateKeyEvent(getKeyEvent));

			case lowercase(K) of // Eventually these will be configurable
			'q': getPLayerInput := LFT;
			's': getPLayerInput := SD;
			'd': getPLayerInput := RGHT;
			'z': getPLayerInput := HOLD;
			'j': getPLayerInput := CW;
			'k': getPLayerInput := CCW;
			'l': getPLayerInput := R180;
			'm': getPLayerInput := HD;
			else getPlayerInput := NOTHING;
			end;
		end;

		DoneKeyboard;
	end;

end.
