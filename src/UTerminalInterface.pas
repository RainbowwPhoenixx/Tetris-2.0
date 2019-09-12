unit UTerminalInterface;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMatrix, UTBoard, UTMovement, UTGeneralInterfaceTypes, UConstantsTerminalInterface, // Imports of custum units
		crt, keyboard; // Imports of default units
	
	procedure clearScreen();
	procedure showMino (mino : TMino);
	procedure showTetrimino (t : TTetrimino);
	procedure showBoard (board : TBoard);
	
	function getPlayerInput () : TMovement;
	
implementation
	
	procedure showMino (mino : TMino);
	begin
		if not isMinoEmpty (mino) then
		begin
			GotoXY (2 * getMinoX(mino), Cmatrix_visible_height - getMinoY(mino) + 1);
			TextBackground(Blue);
			Write('  ');
			TextBackground(Black);
		end;
	end;
	
	procedure showTetrimino (t : TTetrimino);
	var i : byte;
	begin
		for i := 1 to 4 do
			showMino (getIthMino (t, i));
	end;
	
	procedure showBoard (board : TBoard);
	var line : String;
		skin : Text;
		i, j : COORDINATE_TYPE;
	begin
		// First show the skin
		assign(skin, BACKGROUND_PATH);
		reset(skin);
		GotoXY(1,1);
		while not (eof(skin)) do
			begin
				readln (skin, line); //Lit le fichier ligne par ligne et l'affiche
				writeln (line);
			end;
		close(skin);
		
		// Then show the minos in the matrix
		for i := 1 to Cmatrix_visible_width do
			for j := 1 to Cmatrix_visible_height do
				showMino (getMinoFromCoords (getMatrix (board), i, j));
		
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
		key : String;
	begin
		InitKeyboard;
		
		key := KeyEventToString (TranslateKeyEvent (GetKeyEvent()));
		
		case lowercase(key) of // Eventually these will be configurable
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
		
		DoneKeyboard;
	end;
	
end.
