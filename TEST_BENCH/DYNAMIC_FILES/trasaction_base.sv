class transaction_base;

    rand bit [`DATA_WIDTH-1:0] data_in;
    randc bit [`ADDR_WIDTH-1:0] address;
    rand bit write_enb;
    rand bit read_enb;
    logic [`DATA_WIDTH-1:0] data_out;

    static int count;

    constraint set_test {
        if (count < `ADDR_COUNT) {
            soft write_enb == 1'b1;
            soft read_enb  == 1'b0;
        }
        else {
            soft write_enb == 1'b0;
            soft read_enb  == 1'b1;
        }
    }

    virtual function transaction_base copy();
        copy = new();
	copy.data_in   = data_in;
        copy.address   = address;
        copy.write_enb = write_enb;
        copy.read_enb  = read_enb;
        copy.data_out  = data_out;
	return copy;
    endfunction

    function void post_randomize();
        count++;
    endfunction

endclass


class write_first extends transaction_base;
	
    constraint set_write_first {
        {write_enb, read_enb} == 2'b10;
    }

   virtual function transaction_base copy();
        write_first copy1;
	copy1 = new();
	copy1.data_in   = this.data_in;
        copy1.address   = this.address;
        copy1.write_enb = this.write_enb;
        copy1.read_enb  = this.read_enb;
        copy1.data_out  = this.data_out;
        return copy1;
    endfunction 

endclass


class read_first extends transaction_base;

    constraint set_read_first {
        {write_enb, read_enb} == 2'b01;
    }

    virtual function transaction_base copy();
        read_first copy1;
        copy1 = new();
        copy1.data_in   = this.data_in;
        copy1.address   = this.address;
        copy1.write_enb = this.write_enb;
        copy1.read_enb  = this.read_enb;
        copy1.data_out  = this.data_out;
        return copy1;
    endfunction
endclass


class no_write_read extends transaction_base;

    constraint set_no_write_read_c {
        {write_enb, read_enb} == 2'b00;
    }

    virtual function transaction_base copy();
        no_write_read copy1;
        copy1 = new();
        copy1.data_in   = this.data_in;
        copy1.address   = this.address;
        copy1.write_enb = this.write_enb;
        copy1.read_enb  = this.read_enb;
        copy1.data_out  = this.data_out;
        return copy1;
    endfunction
endclass


class both_write_read extends transaction_base;

    constraint set_both_write_read_c {
        {write_enb, read_enb} == 2'b11;
    }

    virtual function transaction_base copy();
        both_write_read copy1;
        copy1 = new();
        copy1.data_in   = this.data_in;
        copy1.address   = this.address;
        copy1.write_enb = this.write_enb;
        copy1.read_enb  = this.read_enb;
        copy1.data_out  = this.data_out;
        return copy1;
    endfunction
endclass
