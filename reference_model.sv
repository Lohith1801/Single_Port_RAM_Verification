class reference_model;
	virtual RAM_inf.REF vinf;
	mailbox #(transaction_base)mbx_drv2ref;
	mailbox #(transaction_base)mbx_ref2scr;
	int count;
	transaction_base tx;
	function new(mailbox #(transaction_base)mbx_drv2ref, mailbox #(transaction_base)mbx_ref2scr, virtual RAM_inf.REF vinf);
		this.mbx_drv2ref = mbx_drv2ref;
		this.mbx_ref2scr = mbx_ref2scr;
		this.vinf = vinf;
	endfunction

	//mem
	logic [`DATA_WIDTH -1:0] ref_mem[0:`ADDR_COUNT -1];

	//
	task run;
		repeat(`TX_COUNT) begin
			mbx_drv2ref.get(tx);
			if(!vinf.cb2ref.rst) begin
			tx.data_out = {`DATA_WIDTH{1'bz}};
			case({tx.write_enb,tx.read_enb})
				2'b10: ref_mem[tx.address] = tx.data_in;
				2'b01: tx.data_out = ref_mem[tx.address];
				default :tx.data_out = tx.data_out ;
			endcase
			$display("@%0t [REF]: Transmitting Transaction packet - %d | write_enb = %d read_enb = %d address = %d data_in = %d data_out = %d",$time,count++,tx.write_enb,tx.read_enb,tx.address,tx.data_in, tx.data_out);
			$display();
			mbx_ref2scr.put(tx);
			end

			else begin
				tx.data_out = {`DATA_WIDTH{1'bz}};
				mbx_ref2scr.put(tx);
			end

			
		end
	endtask

endclass






