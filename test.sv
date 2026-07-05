class test;

	//handle declaration
	virtual RAM_inf.DRV vinf_DRV;
	virtual RAM_inf.MON vinf_MON;
	virtual RAM_inf.REF vinf_REF;
	environment env;

	//constructor
	function new(virtual RAM_inf.DRV vinf_DRV, virtual RAM_inf.MON vinf_MON, virtual RAM_inf.REF vinf_REF);
		this.vinf_DRV = vinf_DRV;
		this.vinf_MON = vinf_MON;
		this.vinf_REF = vinf_REF;
	endfunction

	// run task;
	task run;
		env = new(vinf_DRV, vinf_MON, vinf_REF);
		env.build();
		env.run();
	endtask

endclass
