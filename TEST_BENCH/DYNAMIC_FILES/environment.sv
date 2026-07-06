class environment;
	
	//handle declaration
	mailbox #(transaction_base)mbx_gen2drv;
	mailbox #(transaction_base)mbx_drv2ref;
	mailbox #(transaction_base)mbx_ref2scr;
	mailbox #(transaction_base)mbx_mon2scr;
	generator gen;
	driver drv;
	monitor mon;
	reference_model refer;
	scoreboard scr;
	virtual RAM_inf.DRV vinf_DRV;
	virtual RAM_inf.MON vinf_MON;
	virtual RAM_inf.REF vinf_REF;

	//constrauctor
	function new(virtual RAM_inf.DRV vinf_DRV,virtual RAM_inf.MON vinf_MON,virtual RAM_inf.REF vinf_REF);
		this.vinf_DRV = vinf_DRV;
		this.vinf_MON = vinf_MON;
		this.vinf_REF = vinf_REF;
		mbx_gen2drv = new();
		mbx_drv2ref = new();
		mbx_ref2scr = new();
		mbx_mon2scr = new();
	endfunction
	
	//Build task
	task build;
		gen = new(mbx_gen2drv);
		drv = new(mbx_gen2drv,mbx_drv2ref,vinf_DRV);
		mon = new(mbx_mon2scr,vinf_MON);
		refer = new(mbx_drv2ref,mbx_ref2scr,vinf_REF);
		scr  = new(mbx_ref2scr,mbx_mon2scr);
	endtask

	//Run task
	task run;
		fork
			gen.run();
			drv.run();
			refer.start();
			mon.run();
			scr.run();
		join
		scr.report();
	endtask

endclass

	
