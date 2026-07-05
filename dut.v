
module RAM #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 5, ADDR_COUNT = 32)
	
	(
	input clk, rst,	
	input [DATA_WIDTH -1 :0]data_in,
	input [ADDR_WIDTH -1:0]address,
	input write_enb,
	input read_enb,
	output reg [DATA_WIDTH -1 :0]data_out
);
	
	//memory declaration 
	reg [DATA_WIDTH -1 :0] mem[0:ADDR_COUNT -1];

	
	always@(posedge clk) begin
		if(rst) begin
			data_out <= {DATA_WIDTH{1'bz}};
		end
		else begin
			case({write_enb,read_enb}) 
				2'b00: data_out <= data_out;
				2'b01:	data_out <= mem[address];
				2'b10: mem[address] <= data_in;
				
				default: data_out <= data_out;

			endcase
		end
	end
endmodule






