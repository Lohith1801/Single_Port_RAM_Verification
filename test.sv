class test;

	//handle declaration
	virtual RAM_inf.DRV vinf;
	environment env;

	//constructor
	function new(virtual RAM_inf.DRV vinf);
		this.vinf = vinf;
	endfunction

	// run task;
	task run;
		env = new(vinf);
		env.build();
		env.run();
	endtask

endclass
