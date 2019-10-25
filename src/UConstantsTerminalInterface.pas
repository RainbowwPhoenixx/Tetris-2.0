unit UConstantsTerminalInterface;

interface
	// All display coordinates are given from bottom left

	const
		BACKGROUND_PATH = 'res/terminal_interface_skin.txt';

		Cmatrix_display_x = 11;
		Cmatrix_display_y = 21;

		Chold_real_display_x = 2;
		Chold_real_display_y = 2;

		Chold_display_x = Chold_real_display_x - 8;
		Chold_display_y = Chold_real_display_y - 2 + Cmatrix_display_y;

		Cscore_display_x = Cmatrix_display_x + 27;
		Cscore_display_y = 3;

		Clevel_display_x = Cscore_display_x + 11;
		Clevel_display_y = 3;

		Clines_display_x = Clevel_display_x + 8;
		Clines_display_y = 3;

		Cnext_pieces_real_display_x = Cmatrix_display_x + 24;
		Cnext_pieces_real_display_y = 6;

		Cnext_pieces_display_x = Cnext_pieces_real_display_x - 8;
		Cnext_pieces_display_y = Cnext_pieces_real_display_y - 2 + Cmatrix_display_y;

implementation

end.
