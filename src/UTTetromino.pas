unit UTTetrimino;

interface
	uses UConstants, UTShape, UTMino;
	
	Type TTetrimino = record
		shape : TShapeTetrimino;
		minos : Array[1..4] of TMino;
	end;
	
	// Accessors
	function getIthMino (t: TTetrimino; i : byte) : TMino;
	procedure setIthMino (var t: TTetrimino; i : byte; mino : TMino);
	
	function getTetriminoShape (t: TTetrimino) : TShapeTetrimino;
	procedure setTetriminoShape (var t: TTetrimino; shape : TShapeTetrimino);
	
	// Useful
	function getCenterMino (t: TTetrimino) : TMino;
	procedure setCenterMino (var t: TTetrimino; mino : Tmino);
	
	
implementation
	
	const CENTER_MINO = 3;
	
	// Accessors
	function getIthMino (t: TTetrimino; i : byte) : TMino;
	begin
		getIthMino := t.minos[i];
	end;
	
	procedure setIthMino (var t: TTetrimino; i : byte; mino : TMino);
	begin
		t.minos[i] := mino;
	end;
	
	function getTetriminoShape (t: TTetrimino) : TShapeTetrimino;
	begin
		getTetriminoShape := t.shape;
	end;
	
	procedure setTetriminoShape (var t: TTetrimino; shape : TShapeTetrimino);
	begin
		t.shape := shape;
	end;
	
	// Useful
	function getCenterMino (t: TTetrimino) : TMino;
	begin
		getCenterMino := getIthMino(t, CENTER_MINO);
	end;
	
	procedure setCenterMino (var t: TTetrimino; mino : Tmino);
	begin
		setIthMino(t, CENTER_MINO, mino);
	end;
	
end.
