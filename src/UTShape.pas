unit UTShape;

interface
	uses UConstants;

	Type TShapeTetrimino = (I, T, L, J, S, Z, O, VOID);

	function getRandomShape () : TShapeTetrimino;
implementation

	function getRandomShape () : TShapeTetrimino;
	begin
		getRandomShape := TShapeTetrimino(random(7));
	end;
end.
