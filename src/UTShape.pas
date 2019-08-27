unit UTshape;

interface
	uses UConstants;
	
	Type TShapeTetrimino = (I, T, L, J, S, Z, O);
	
	function getRandomShape () : TShapeTetrimino;
implementation
	
	function getRandomShape () : TShapeTetrimino;
	begin
		getRandomShape := TShapeTetrimino(random(7)); 
	end;
end.
