class scoreboard;
	mailbox #(transaction_base)mbx_ref2scr;
	mailbox #(transaction_base)mbx_mon2scr;
	int pass_count, fail_count;
	real pass_percentage;
	transaction_base exp;
	transaction_base out;
	transaction_base Qexp[$];
	transaction_base Qout[$], Qout2[$];
	int count;


	//int que[$];
	//que[45]=65;
	function new(mailbox #(transaction_base)mbx_ref2scr, mailbox #(transaction_base)mbx_mon2scr);
		this.mbx_ref2scr = mbx_ref2scr;
		this.mbx_mon2scr = mbx_mon2scr;
	endfunction

	task run;
		repeat(`TX_COUNT) begin
			mbx_ref2scr.get(exp);
			Qexp.push_back(exp);
		end
		repeat(`TX_COUNT+1) begin
                        mbx_mon2scr.get(out);
                        Qout.push_back(out);
                end
		Qout2 = Qout[1:$];
		while(count < `TX_COUNT) begin
			if(Qexp[count].data_out === Qout2[count].data_out) begin
				pass_count++;
				$display("[SCR]: PASS");
			end
			else begin
				fail_count++;
				$display();
				$display("[SCR]: FAILED");
				$display("[SCR]: EXPECTED Results address = %d data_in = %d write_enb = %d read_enb = %d data_out = %d",Qexp[count].address, Qexp[count].data_in, Qexp[count].write_enb, Qexp[count].read_enb, Qexp[count].data_out);
				$display("[SCR]: DUT Results address = %d data_in = %d write_enb = %d read_enb = %d data_out = %d",Qout[count].address, Qout[count].data_in, Qout[count].write_enb, Qout[count].read_enb, Qout[count].data_out);
			end
			count++;
		end
	endtask

	task report;
		$display("----------------------------------------VERFICATION REPORT---------------------------------------------");
		pass_percentage = (100.0 * pass_count) / (pass_count + fail_count);
		$display("PASS COUNT = %d", pass_count);
		$display("FAIL COUNT = %d", fail_count);
		$display("PASS PERCENTAGE = %0.2f%%", pass_percentage);
	        $display("-------------------------------------------------------------------------------------------------------");
	endtask
endclass


				

