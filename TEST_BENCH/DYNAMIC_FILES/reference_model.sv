///*
///************************************************************************
//Copyright 2013-2014 - RV-VLSI. All Rights Reserved.
//*************************************************************************
//thor:         gerard@rv-vlsi.com
//
//Filename:	ram_reference_model.sv   
//
//Date:   	1st July 2014
//
//Version:	1.0
//************************************************************************/
//class reference_model;
////PROPERTIES
//  //Ram transaction class handle
//   transaction_base ref_trans;
//  //Mailbox for reference model to scoreboard connection
//   mailbox #(transaction_base) mbx_rs;
//  //Mailbox for driver to reference model connection
//   mailbox #(transaction_base) mbx_dr;
//  //Virtual interface with driver modport and it's instance
//   virtual RAM_inf.REF vif;
//  //Associative array used for mimicing the functionality of the RAM
//   bit [7:0] MEM [bit [31:0]];
//
////METHODS
//  //Explicitly overriding the constructor to make mailbox connection from driver
//  //to reference model, to make mailbox connection from reference model to scoreboard
//  //and to connect the virtual interface from reference model to enviornment 
//  function new(mailbox #(transaction_base) mbx_dr,
//               mailbox #(transaction_base) mbx_rs,
//               virtual RAM_inf.REF vif);
//    this.mbx_dr=mbx_dr;
//    this.mbx_rs=mbx_rs;
//    this.vif=vif;
//  endfunction
//
//  //Task which mimics the functionality of the RAM
//  task start();
//    for(int i=0;i<`TX_COUNT;i++)
//     begin
//      ref_trans=new();
//     //getting the driver transaction from mailbox 
//      mbx_dr.get(ref_trans);
//      repeat(1) @(vif.cb2ref)
//       begin 
//        if(ref_trans.write_enb)
//         MEM[ref_trans.address]=ref_trans.data_in;
//        $display("REFERENCE MODEL DATA IN MEMORY MEM[ADDRESS]=%d",MEM[ref_trans.address],$time);
//        if(ref_trans.read_enb)
//         ref_trans.data_out=MEM[ref_trans.address];
//        $display("REFERENCE MODEL DATA OUT FROM MEMORY data_out=%d",ref_trans.data_out,$time);
//       end
//     //Putting the reference model transaction to mailbox 
//      mbx_rs.put(ref_trans);
//     end 
//  endtask
//endclass
// 
//
//




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
	task start;
		repeat(`TX_COUNT) begin
			mbx_drv2ref.get(tx);
			if(vinf.cb2ref.rst) begin
			tx.data_out = {`DATA_WIDTH{1'bz}};
			case({tx.write_enb,tx.read_enb})
				2'b10: ref_mem[tx.address] = tx.data_in;
				2'b01: tx.data_out = ref_mem[tx.address];
				default : ;
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






