`define DATA_WIDTH 8
`define ADDR_COUNT 2
`define TX_COUNT 4

function automatic int log_base2(int val);
	log_base2 = 0;
	while(2**log_base2 < val) begin
		log_base2++;
	end
	return log_base2;
endfunction
`define ADDR_WIDTH log_base2(`ADDR_COUNT)

