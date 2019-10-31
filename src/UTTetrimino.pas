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
	function areTetriminoIdentical (t1, t2 : TTetrimino) : Boolean;

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
			tetri.minos[1] := newMino(4,20, shape); // Each mino gets an initilized
			tetri.minos[2] := newMino(5,20, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,20, shape);
		   end;

		T: begin
			tetri.minos[1] := newMino(5,20, shape);
			tetri.minos[2] := newMino(6,19, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,20, shape);
		   end;

		L: begin
			tetri.minos[1] := newMino(5,19, shape);
			tetri.minos[2] := newMino(5,20, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,20, shape);
		   end;

		J: begin
			tetri.minos[1] := newMino(7,19, shape);
			tetri.minos[2] := newMino(5,20, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,20, shape);
		   end;

		S: begin
			tetri.minos[1] := newMino(5,19, shape);
			tetri.minos[2] := newMino(6,19, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,20, shape);
		   end;

		Z: begin
			tetri.minos[1] := newMino(5,20, shape);
			tetri.minos[2] := newMino(6,19, shape);
			tetri.minos[3] := newMino(6,20, shape);
			tetri.minos[4] := newMino(7,19, shape);
		   end;

		O: begin
			tetri.minos[1] := newMino(5,19, shape);
			tetri.minos[2] := newMino(6,19, shape);
			tetri.minos[3] := newMino(5,20, shape);
			tetri.minos[4] := newMino(6,20, shape);
		   end;
		end; // End case ... of

		tetri.shape := shape;
		newTetrimino := tetri;
	end;

	function areTetriminoIdentical (t1, t2 : TTetrimino) : Boolean;
	var
		res : Boolean;
		i : byte;
	begin
	res := True;
	res := res and (getTetriminoShape(t1) = getTetriminoShape(t2));

	for i := 1 to 4 do
		res := res and areMinoIdentical (getIthMino (t1, i), getIthMino (t2, i));

	areTetriminoIdentical := res;
	end;

end.
