class generator;

	//handle declarations
	mailbox #(transaction_base)mbx_gen2drv;
	transaction_base tx;

	//Constructor
	function new(mailbox #(transaction_base)mbx_gen2drv);
		this.mbx_gen2drv = mbx_gen2drv;
	endfunction

	//generator initiator task
	task run;
		repeat(`TX_COUNT/2) begin
			tx = new();
			assert(tx.randomize() with {write_enb == 1; read_enb == 0;}) begin
				$display("Generated new Packet...");
				mbx_gen2drv.put(tx);
			end
			else begin
				$display("Packet Randomization FAILED");
			end
		end
		repeat(`TX_COUNT/2) begin
                        tx = new();
			assert(tx.randomize() with {write_enb == 0; read_enb == 1 ;}) begin
                                $display("Generated new Packet...");
                                mbx_gen2drv.put(tx);
                        end
                        else begin
                                $display("Packet Randomization FAILED");
                        end
                end
	endtask

endclass


