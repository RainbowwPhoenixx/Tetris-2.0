unit UTTetrimino;

interface
	uses UConstants, UTShape, UTMino, UTMovement;
	
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
	
	function moveTetrimino (t: TTetrimino; movement : TMovement) : TTetrimino;
	
	// Function to create tetriminos
	function newTetrimino (shape : TShapeTetrimino) : TTetrimino;
	
implementation
	
	const Ccenter_mino = 3;
	
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
	
	//Private functions
	function shiftTetrominoXAxis (t : TTetrimino; direction: String) : TTetrimino;
	var
		i : byte;
		tmpTetrimino : TTetrimino;
		tmpMino : TMino;
	begin
		for i := 1 to 4 do
		begin
			tmpMino := shiftMinoXAxis (getIthMino(t, i), direction);
			setIthMino(tmpTetrimino, i, tmpMino);
		end;
		
		shiftTetrominoXAxis := tmpTetrimino;
	end;
	
	function shiftTetrominoYAxis (t : TTetrimino; direction: String) : TTetrimino;
	var
		i : byte;
		tmpTetrimino : TTetrimino;
		tmpMino : TMino;
	begin
		for i := 1 to 4 do
		begin
			tmpMino := shiftMinoYAxis (getIthMino(t, i), direction);
			setIthMino(tmpTetrimino, i, tmpMino);
		end;
		
		shiftTetrominoYAxis := tmpTetrimino;
	end;
	
	
	// Useful
	function getCenterMino (t: TTetrimino) : TMino;
	begin
		getCenterMino := getIthMino(t, Ccenter_mino);
	end;
	
	procedure setCenterMino (var t: TTetrimino; mino : Tmino);
	begin
		setIthMino(t, Ccenter_mino, mino);
	end;
	
	function newTetrimino (shape : TShapeTetrimino) : TTetrimino;
	var
		tetri : TTetrimino;
	begin		
		case shape of  //I, T, L, J, S, Z, O
		I: begin // Initial position of the I
			tetri.minos[1] := newMino(4,20, False, shape); // Each mino gets an initilized
			tetri.minos[2] := newMino(5,20, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,20, False, shape);
		   end;
		   
		T: begin
			tetri.minos[1] := newMino(5,20, False, shape);
			tetri.minos[2] := newMino(6,19, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,20, False, shape);
		   end;
		   
		L: begin
			tetri.minos[1] := newMino(5,19, False, shape);
			tetri.minos[2] := newMino(5,20, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,20, False, shape);
		   end;
		   
		J: begin
			tetri.minos[1] := newMino(7,19, False, shape);
			tetri.minos[2] := newMino(5,20, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,20, False, shape);
		   end;
		   
		S: begin
			tetri.minos[1] := newMino(5,19, False, shape);
			tetri.minos[2] := newMino(6,19, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,20, False, shape);
		   end;
		   
		Z: begin
			tetri.minos[1] := newMino(5,20, False, shape);
			tetri.minos[2] := newMino(6,19, False, shape);
			tetri.minos[3] := newMino(6,20, False, shape);
			tetri.minos[4] := newMino(7,19, False, shape);
		   end;
		   
		O: begin
			tetri.minos[1] := newMino(5,19, False, shape);
			tetri.minos[2] := newMino(6,19, False, shape);
			tetri.minos[3] := newMino(5,20, False, shape);
			tetri.minos[4] := newMino(6,20, False, shape);
		   end;
		end; // End case ... of
		
		tetri.shape := shape;
		newTetrimino := tetri;
	end;
	
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
			
		   end;
		   
		CCW: begin
			
		   end;
		   
		R180: begin
			
		   end;
		   
		HOLD: begin
			// Basically same as HD
		   end;
		NOTHING:;
		end;
	moveTetrimino := tmpTetrimino;
	end;
	
end.
