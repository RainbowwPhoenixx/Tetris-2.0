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

	procedure showMino (mino : TMino);
	begin
		if not isMinoEmpty (mino) then
		begin
			if getMinoY (mino) < Cmatrix_visible_height + 1 then //Display the mino only if it is in the visible part of the matrix.
			begin
				GotoXY (Cmatrix_display_x + 2 * getMinoX(mino), Cmatrix_display_y - getMinoY(mino) + 1);
				TextBackground(Blue);
				Write('  ');
				TextBackground(Black);
			end;
		end;
	end;


	procedure initializeDisplay ();
	begin
		//nop
	end;

	procedure showMatrix (matrix : TMatrix);
	var
		i, j : COORDINATE_TYPE;
	begin
		for i := 1 to Cmatrix_visible_width do
			for j := 1 to Cmatrix_visible_height do
				showMino (getMinoFromCoords (matrix, i, j));
	end;

	procedure showNextQueue (nextQueue : TNextPieces);
	begin
		// Nop for now
	end;

	procedure showHoldPiece (piece : TShapeTetrimino);
	begin
		// Nop for now
	end;

	procedure showScore (score : SCORE_TYPE);
	begin
		// Nop for now
	end;

	procedure showLevel (level : byte);
	begin
		// Nop for now
	end;

	procedure showTetrimino (t : TTetrimino);
	var i : byte;
	begin
		for i := 1 to 4 do
			showMino (getIthMino (t, i));
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
		//clearMatrix ();
		// First show the skin
		showSkin (); // May change to show the skin only once at the beginning

		// Then show the minos in the matrix
		showMatrix (getMatrix(board));

		// Then show the active tetrimino
		showTetrimino (getActiveTetrimino (getMatrix (board)));

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
