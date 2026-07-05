
class transaction_base;
	rand bit [`DATA_WIDTH -1 :0]data_in;
	randc bit [`ADDR_WIDTH -1:0]address;
	rand bit write_enb;
	rand bit read_enb;
	logic [`DATA_WIDTH -1 :0]data_out;
endclass

