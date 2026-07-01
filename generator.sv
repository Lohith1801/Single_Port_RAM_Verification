class generator;
	mailbox #(transaction)mbx_gen2drv;
	transaction tx;
	function new(mailbox mbx_gen2drv);
		this.mbx_gen2drv = mbx_gen2drv;
		this.tx = new();
	endfunction

	task run;
		repeat(10) begin
			assert(tx.randomize()) begin
				$display("Generated new Packet...");
				mbx_gen2drv.put(tx);
			end
			else begin
				$display("Packet Randomization FAILED");
			end
		end
	endtask

endclass


