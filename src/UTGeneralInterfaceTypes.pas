unit UTGeneralInterfaceTypes;

interface
	uses UConstants, UTShape, UTMino, UTTetrimino, UTMovement, UTMatrix, UTBoard, UTNextPieces;

	Type
		// Procedure types out
		TinitDisplay = procedure (); // Fonction to run once at the beginning to initialize the display
		TresetScreen =  procedure (); // Cleans whole screen the with
		TclearMatrix = procedure (); // Cleans the matrix area with whitespace

		TshowMatrix = procedure (matrix : TMatrix); // Displays the Matrix
		TshowTetrimino = procedure (tetri : TTetrimino); // Displays the active tetrimino
		TshowNextQueue = procedure (queue : TNextPieces); // Displays the next queue
		TshowHold = procedure (piece : TShapeTetrimino); // Displays the hold piece
		TshowBoard = procedure (board : TBoard); // Displays the whole board. (Should it just be a wrapper for other display functions ?)

		TshowScore = procedure (score : SCORE_TYPE); // Displays the current score
		TshowLevel = procedure (level : byte); // Displays the current level
		// Procedure types in
		TgetMovement = function () : TMovement; // Gets the inputs from the player


	// general structure to facilitate passing all the display functions in procedures
	Type IO_Interface = record
		initOut       : TinitDisplay;
		BackgroundOut : TresetScreen;
		MatrixResetOut: TclearMatrix;

		MatrixOut     : TshowMatrix;
		TetriminoOut  : TshowTetrimino;
		NextQueueOut  : TshowNextQueue;
		HoldOut       : TshowHold;
		BoardOut      : TshowBoard;

		ScoreOut      : TshowScore;
		LevelOut      : TshowLevel;

		PlayerIn      : TgetMovement;
	end;

	function newInterface (initOutFunc       : TinitDisplay;
												 BackgroundOutFunc : TresetScreen;
												 MatrixResetOutFunc: TclearMatrix;
												 MatrixOutFunc     : TshowMatrix;
												 TetriminoOutFunc  : TshowTetrimino;
												 NextQueueOutFunc  : TshowNextQueue;
												 HoldOutFunc       : TshowHold;
												 BoardOutFunc      : TshowBoard;
												 ScoreOutFunc      : TshowScore;
												 LevelOutFunc      : TshowLevel;
												 PlayerInFunc      : TgetMovement     ) : IO_Interface;

implementation

	function newInterface (initOutFunc       : TinitDisplay;
												 BackgroundOutFunc : TresetScreen;
												 MatrixResetOutFunc: TclearMatrix;
												 MatrixOutFunc     : TshowMatrix;
												 TetriminoOutFunc  : TshowTetrimino;
												 NextQueueOutFunc  : TshowNextQueue;
												 HoldOutFunc       : TshowHold;
												 BoardOutFunc      : TshowBoard;
												 ScoreOutFunc      : TshowScore;
												 LevelOutFunc      : TshowLevel;
												 PlayerInFunc      : TgetMovement     ) : IO_Interface;
	var
		IO : IO_Interface;
	begin
		IO.initOut        := initOutFunc;
		IO.BackgroundOut  := BackgroundOutFunc;
		IO.MatrixResetOut := MatrixResetOutFunc;
		IO.MatrixOut      := MatrixOutFunc;
		IO.TetriminoOut   := TetriminoOutFunc;
		IO.NextQueueOut   := NextQueueOutFunc;
		IO.HoldOut        := HoldOutFunc;
		IO.BoardOut       := BoardOutFunc;
		IO.ScoreOut       := ScoreOutFunc;
		IO.LevelOut       := LevelOutFunc;
		IO.PlayerIn       := PlayerInFunc;

		newInterface := IO;
	end;

end.
