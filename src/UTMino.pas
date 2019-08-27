unit UTMino;

interface
	uses UConstants, UTShape;
	
	Type TMino = record
		minoType : TShapeTetrimino;
		empty : boolean;
		x,y : COORDINATE_TYPE;
	end;
	// Accessors
	function getMinoX (mino : TMino) : COORDINATE_TYPE;
	function getMinoY (mino : TMino) : COORDINATE_TYPE;
	function getMinoType (mino : TMino) : TShapeTetrimino;
	function isMinoEmpty (mino : TMino) : Boolean;
	procedure setMinoX (var mino : TMino; x : COORDINATE_TYPE);
	procedure setMinoY (var mino : TMino; y : COORDINATE_TYPE);
	procedure setMinoType (var mino : TMino; shape : TShapeTetrimino);
	procedure setMinoEmpty (var mino : TMino; empty : Boolean);
	
	//Useful operations
	function newMino (x, y : COORDINATE_TYPE;
					  empty : Boolean;
					  shape : TShapeTetrimino) : TMino;
	
implementation
	//Accessors
	function getMinoX (mino : TMino) : COORDINATE_TYPE;
	begin
		getMinoX := mino.x;
	end;
	
	function getMinoY (mino : TMino) : COORDINATE_TYPE;
	begin
		getMinoY := mino.y;
	end;
	
	function getMinoType (mino : TMino) : TShapeTetrimino;
	begin
		getMinoType := mino.minoType;
	end;
	
	function isMinoEmpty (mino : TMino) : Boolean;
	begin
		isMinoEmpty := mino.empty;
	end;
	
	procedure setMinoX (var mino : TMino; x : COORDINATE_TYPE);
	begin
		mino.x := x;
	end;
	
	procedure setMinoY (var mino : TMino; y : COORDINATE_TYPE);
	begin
		mino.y := y;
	end;
	
	procedure setMinoType (var mino : TMino; shape : TShapeTetrimino);
	begin
		mino.minoType := shape;
	end;
	
	procedure setMinoEmpty (var mino : TMino; empty : Boolean);
	begin
		mino.empty := empty;
	end;
	
	// Useful
	function newMino (x, y : COORDINATE_TYPE; empty : Boolean; shape : TShapeTetrimino) : TMino;
	var
		mino : TMino;
	begin
		setMinoEmpty (mino, empty);
		setMinoType (mino, shape);
		setMinoX (mino, x);
		setMinoY (mino, y);
		
		newMino := mino;
	end;
	
end.
