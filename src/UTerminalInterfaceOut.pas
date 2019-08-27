unit UTerminalInterfaceOut;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTGeneralInterfaceTypes, // Imports of custum units
		crt; // Imports of default units
	
	
	procedure showMino (mino : TMino);
	procedure showTetrimino (t : TTetrimino);
	
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
	
end.
