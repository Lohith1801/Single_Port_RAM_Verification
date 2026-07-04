class driver;
	
	//handle declarations 
	virtual RAM_inf.DRV vinf;
	transaction_base tx;
	mailbox #(transaction_base)mbx_gen2drv;
	
	
	//covergroup
	covergroup cg;
		cp_address: coverpoint tx.address{
			bins b1[] = {[0:31]};
		}

		cp_data_in: coverpoint tx.data_in;
		
		cp_write_enb: coverpoint tx.write_enb{
			bins b2[] = {0,1};
		}
		
		cp_read_enb: coverpoint tx.read_enb{
			bins b2[] = {0,1};
		}

		address_X_write_enb: cross cp_address,cp_write_enb;
		
		address_X_read_enb: cross cp_address,cp_read_enb;
	endgroup
	

        //Constructor
        function new(mailbox #(transaction_base)mbx_gen2drv, virtual RAM_inf.DRV vinf);
                this.mbx_gen2drv = mbx_gen2drv;
                this.vinf = vinf;
                cg = new();
        endfunction


	//run task
	task run;
		repeat(10) begin
			mbx_gen2drv.get(tx);
			@(vinf.cb2drv);
			if(!vinf.cb2drv.rst) begin
					vinf.cb2drv.write_enb <= tx.write_enb;
					vinf.cb2drv.read_enb <= tx.read_enb;
					vinf.cb2drv.address <= tx.address;
					vinf.cb2drv.data_in <= tx.data_in;
					cg.sample();
					$display("[DRV] : Driving Packet , write_enb = %d read_enb = %d address = %d data_in = %d",tx.write_enb,tx.read_enb,tx.address,tx.data_in);
			end
			else begin
				vinf.cb2drv.write_enb <= 0;
				vinf.cb2drv.read_enb <= 0;
				vinf.cb2drv.address <= 0;
				vinf.cb2drv.data_in <= 0;
				cg.sample();
				$display("[DRV] : RESET IS ASSERTED, NO PACKECT IS DRIVED TO DUT!"); 
			end
		end
	endtask

endclass






			


