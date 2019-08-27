unit UTGeneralInterfaceTypes;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement;
	
	Type // Procedure types out
		TshowMatrix = procedure ();
		TshowMino = procedure (mino : TMino);
		TshowTetrimino = procedure (tetri : TTetrimino);
		// Procedure types in
		TgetMovement = function ():TMovement;
	
	
	// general structure to facilitate passing all the display functions in procedures
	Type IO_Interface = record
		MatrixOut    : TshowMatrix;
		MinoOut      : TshowMino;
		TetriminoOut : TshowTetrimino;
		
		PlayerIn     : TgetMovement;
	end;
	
	function newInterface (matrixDisplayFunc    : TshowMatrix;
	                       minoDisplayFunc      : TshowMino;
	                       tetriminoDisplayFunc : TshowTetrimino;
	                       playerInputFunc      : TgetMovement   ) : IO_Interface;
	
implementation
	
	function newInterface (matrixDisplayFunc    : TshowMatrix;
	                       minoDisplayFunc      : TshowMino;
	                       tetriminoDisplayFunc : TshowTetrimino;
	                       playerInputFunc      : TgetMovement   ) : IO_Interface;
	var
		IO : IO_Interface;
	begin
		IO.MatrixOut    := matrixDisplayFunc;
		IO.MinoOut      := minoDisplayFunc;
		IO.TetriminoOut := tetriminoDisplayFunc;
		IO.PlayerIn     := playerInputFunc;
		
		newInterface := IO;
	end;
	
end.
