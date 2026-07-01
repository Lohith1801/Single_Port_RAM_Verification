`include"defines.svh"

class transaction_base;
	rand logic [`DATA_WIDTH -1 :0]data_in;
	rand logic [`ADDR_WIDTH -1:0]address;
	rand logic write_enb;
	rand logic read_enb;
	rand logic [`DATA_WIDTH -1 :0]data_out;
endclass

