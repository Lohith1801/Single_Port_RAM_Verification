class generator;

        mailbox #(transaction_base) mbx_gen2drv;
        transaction_base tx;

        function new(mailbox #(transaction_base) mbx_gen2drv);
                this.mbx_gen2drv = mbx_gen2drv;
                tx = new();
        endfunction

        task run;
                transaction_base pkt;

                $display("TX_COUNT = %d", `TX_COUNT);

                repeat(`TX_COUNT) begin
                        assert(tx.randomize()==1) begin
                                $display("Generated new Packet...");
                                mbx_gen2drv.put(tx.copy());
                        end
                        else begin
                                $display("Packet Randomization FAILED");
                        end
                end
        endtask

endclass
