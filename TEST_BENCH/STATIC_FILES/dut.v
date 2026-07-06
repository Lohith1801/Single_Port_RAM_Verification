
/************************************************************************
Copyright 2013-2014 - RV-VLSI. All Rights Reserved.
*************************************************************************
Author:         vaibbhav@rv-vlsi.com

Filename:	ram.sv   

Date:   	1st July 2014

Version:	1.0
************************************************************************/
module RAM(
          clk, // Clk input
          reset, //Reset input active low
          address, // Address Input
          data_in, // Data in 
          write_enb, // Write Enable
          read_enb,  // Read Enable
          data_out   // Data out
          );          

//Input port declaration
 input [1:0] address;
 input write_enb;
 input read_enb; 
 input [7:0] data_in;
 input clk;
 input reset; 

//Output port declaration 
 output [7:0] data_out;
 
//Variable declarations 
 reg [7:0] data_out ;
 reg [7:0] memory [0:31];

//Memory Write Block Write Operation : When write_enb = 1,
always @(posedge clk)
 begin 
  if(!reset)
   memory[address] <= 8'bz;
  else if(write_enb && !read_enb) 
   memory[address] <= data_in;
 end 
 
//Memory Read Block  Read Operation : When read_enb=1
always @(posedge clk)
 begin
  if(!reset) 
    data_out <= 8'bz;
  else if(read_enb && !write_enb)
    data_out <= memory[address];
  else
    data_out <= 8'bz;
 end
endmodule 







/*
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
*/





