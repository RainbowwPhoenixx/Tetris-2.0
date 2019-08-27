unit UTerminalInterface;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTGeneralInterfaceTypes, // Imports of custum units
		crt, keyboard; // Imports of default units
	
	procedure clearScreen();
	procedure showMino (mino : TMino);
	procedure showTetrimino (t : TTetrimino);
	
	function getPlayerInput () : TMovement;
	
implementation
	
	procedure showMino (mino : TMino);
	begin
		GotoXY (2 * getMinoX(mino), Cmatrix_visible_height - getMinoY(mino) + 1);
		TextBackground(Blue);
		Write('  ');
		TextBackground(Black);
	end;
	
	procedure showTetrimino (t : TTetrimino);
	var i : byte;
	begin
		for i := 1 to 4 do
			showMino (getIthMino (t, i));
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
		'l': getPLayerInput := CW;
		'm': getPLayerInput := CCW;
		'ù': getPLayerInput := R180;
		'*': getPLayerInput := HD;
		else getPlayerInput := NOTHING;
		end;
		
		DoneKeyboard;
	end;
	
	
end.
