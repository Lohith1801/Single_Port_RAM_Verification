`include"defines.svh"
interface RAM_inf(input bit clk,rst);
	logic [`DATA_WIDTH -1:0]data_in, data_out;
	logic write_enb, read_enb;
	logic [`ADDR_WIDTH-1:0]address;

	clocking cb2drv @(posedge clk);
		default input #0 output #0;
		input rst;
		output write_enb, read_enb, data_in, address;	
	endclocking

	clocking cb2mon @(posedge clk);
		default input #0 output #0;
		input data_out;
	endclocking

	clocking cb2ref @(posedge clk);
		default input #0 output #0;
		input rst;
	endclocking

	modport DRV(clocking cb2drv);
	modport MON(clocking cb2mon);
	modport REF(clocking cb2ref);

endinterface	
