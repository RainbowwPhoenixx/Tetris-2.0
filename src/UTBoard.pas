unit UTBoard;

interface
	
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTGeneralInterfaceTypes, UTerminalInterface;
	
	Type TBoard = record
		holdPiece : TShapeTetrimino;
		matrix : Array [1..Cmatrix_width,1..Cmatrix_height] of TMino;
		nextQueue : Array [1..Cnext_queue_length] of TShapeTetrimino;
		
		level : byte;
		score : SCORE_TYPE;
	end;
	
	
implementation
	
end.
