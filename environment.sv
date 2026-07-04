class environment;
	
	//handle declaration
	mailbox #(transaction_base)mbx_gen2drv;
	generator gen;
	driver drv;
	virtual RAM_inf.DRV vinf;

	//constrauctor
	function new(virtual RAM_inf.DRV vinf);
		this.vinf = vinf;
		mbx_gen2drv = new();
	endfunction
	
	//Build task
	task build;
		gen = new(mbx_gen2drv);
		drv = new(mbx_gen2drv,vinf);
	endtask

	//Run task
	task run;
		fork
			gen.run();
			drv.run();
		join
	endtask

endclass

	
