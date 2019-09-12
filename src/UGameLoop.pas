UNIT UGameLoop;

INTERFACE

  USES UTBoard, UTMovement, UTerminalInterface, crt;

  PROCEDURE mainLoop(var board : TBoard);

IMPLEMENTATION

  PROCEDURE mainLoop(var board : TBoard);
  var
    move: TMovement;
  BEGIN

    // Look for inputs from the player
    move := getPlayerInput ();
    // Apply those inputs to the board
    handleEvent (board, move);
    // Display the board
    showBoard (board);
    // Wait some time for the next frame.
    delay (100);

  END;

END.
