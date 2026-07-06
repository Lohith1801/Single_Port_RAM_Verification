class monitor;
	
	//handle declaration
	virtual RAM_inf.MON vinf;
	mailbox #(transaction_base)mbx_mon2scr;
	transaction_base tx;
	int count;
	//CONSTRUCTOR
	function new(mailbox #(transaction_base)mbx_mon2scr, virtual RAM_inf.MON vinf);
		this.mbx_mon2scr = mbx_mon2scr;
		this.vinf = vinf;
	endfunction

	//run Task
	task run;
		repeat(`TX_COUNT+1) begin
			@(vinf.cb2mon);
			if(vinf.cb2mon.rst) begin
				tx = new();
				tx.write_enb = vinf.cb2mon.write_enb;
				tx.read_enb = vinf.cb2mon.read_enb;
				tx.address = vinf.cb2mon.address;
				tx.data_out = vinf.cb2mon.data_out;
				tx.data_in = vinf.cb2mon.data_in;
				mbx_mon2scr.put(tx);
				$display("@%0t [MON]: Transmitting Transaction packet - %d | write_enb = %d read_enb = %d address = %d data_in = %d data_out = %d",$time,count++,tx.write_enb,tx.read_enb,tx.address,tx.data_in,tx.data_out);
			end
			else begin
				$display();
				$display("@%0t [MON]: RESET IS ASSERTED!!",$time);
				$display();
			end
		end
	endtask
endclass



