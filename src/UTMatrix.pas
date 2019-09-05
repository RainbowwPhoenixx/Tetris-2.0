unit UTMatrix;

interface
	
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement;
	
	Type TMatrix = record
			grid : Array [1..Cmatrix_width,1..Cmatrix_height] of TMino;
			activeTetrimino : TTetrimino;
		end;
	
	// Accessors for TMatrix
	function getMinoFromCoords (matrix : TMatrix; x, y : COORDINATE_TYPE) : TMino;
	procedure setMinoAtCoords (var matrix : TMatrix; x, y : COORDINATE_TYPE; mino : TMino);
	
	function getActiveTetrimino (matrix : TMatrix) : TTetrimino;
	procedure setActiveTetrimino (var matrix : TMatrix; tetri : TTetrimino); 
	
	
implementation
	
	// Accessors for TMatrix
	function getMinoFromCoords (matrix : TMatrix; x, y : COORDINATE_TYPE) : TMino;
	begin
		getMinoFromCoords := matrix.grid[x][y];
	end;
	
	procedure setMinoAtCoords (var matrix : TMatrix; x, y : COORDINATE_TYPE; mino : TMino);
	begin
		matrix.grid[x][y] := mino;
	end;
	
	function getActiveTetrimino (matrix : TMatrix) : TTetrimino;
	begin
		getActiveTetrimino := matrix.activeTetrimino;
	end;
	
	procedure setActiveTetrimino (var matrix : TMatrix; tetri : TTetrimino); 
	begin
		matrix.activeTetrimino := tetri;
	end;
	
	// Useful functions
	function initMatrix (shape : TShapeTetrimino) : TMatrix;
	var
		tmpMat : Tmatrix;
		tmpMino : TMino;
		i, j : byte;
	begin
		// Creates a matrix with 'shape' as the active piece and an empty grid.
		
		setActiveTetrimino (tmpMat, newTetrimino (shape));
		
		for i := 1 to Cmatrix_height do
			for j := 1 to Cmatrix_width do
			begin
				tmpMino := newMino (j, i, True, O); // mino shape doesn't matter since it is empty.
				setMinoAtCoords (tmpMat, j, i, tmpMino);
			end;
		initMatrix := tmpMat;
	end;
	
end.
