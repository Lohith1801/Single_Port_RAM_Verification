`include"interface.sv"

module test_bench;

	import tb_pkg::*; 
	bit clk,rst;

	initial begin
		forever #5 clk = ~clk;
	end

	RAM_inf inf(clk,rst);
	RAM dut(.data_in(inf.data_in),.write_enb(inf.write_enb),.read_enb(inf.read_enb), .address(inf.address), .clk(clk), .rst(rst), .data_out(inf.data_out));

	test T = new(inf.DRV);

	initial begin
		rst = 1;
		#10 rst =0; 
		T.run();
		#20 $finish;
	end
endmodule


