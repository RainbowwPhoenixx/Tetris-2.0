unit UTTetromino;

interface
	uses UConstants, UTShape, UTMino;
	
	Type TTetromino = record
		shape : TShapeTetrimino;
		minos : Array[1..4] of TMino;
	end;
implementation
	
end.
