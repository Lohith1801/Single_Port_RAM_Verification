class test;

        virtual RAM_inf.DRV vinf_DRV;
        virtual RAM_inf.MON vinf_MON;
        virtual RAM_inf.REF vinf_REF;
        environment env;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                this.vinf_DRV = vinf_DRV;
                this.vinf_MON = vinf_MON;
                this.vinf_REF = vinf_REF;
                env = new(vinf_DRV, vinf_MON, vinf_REF);
                env.build();
        endfunction

        virtual task run;
                env.run();
                $display();
                $display("-----------------------------------------------------COVERAGE REPORT-----------------------------------------------------------------");
                $display(" COVERAGE = %0.2f%%",env.drv.cg.get_coverage());
        endtask

endclass


class test_write_first extends test;

        write_first tx;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                super.new(vinf_DRV,vinf_MON,vinf_REF);
        endfunction

        task run;
                tx = new();
                env.gen.tx = tx;
                super.run();
        endtask

endclass


class test_read_first extends test;

        read_first tx;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                super.new(vinf_DRV,vinf_MON,vinf_REF);
        endfunction

        task run;
                tx = new();
                env.gen.tx = tx;
                super.run();
        endtask

endclass


class test_no_write_read extends test;

        no_write_read tx;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                super.new(vinf_DRV,vinf_MON,vinf_REF);
        endfunction

        task run;
                tx = new();
                env.gen.tx = tx;
                super.run();
        endtask

endclass


class test_both_write_read extends test;

        both_write_read tx;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                super.new(vinf_DRV,vinf_MON,vinf_REF);
        endfunction

        task run;
                tx = new();
                env.gen.tx = tx;
                super.run();
        endtask

endclass

class test_regression extends test;

        test  test1;
        test_write_first    test2;
        test_read_first     test3;
        test_no_write_read  test4;
        test_both_write_read test5;

        function new(virtual RAM_inf.DRV vinf_DRV,
                     virtual RAM_inf.MON vinf_MON,
                     virtual RAM_inf.REF vinf_REF);
                super.new(vinf_DRV,vinf_MON,vinf_REF);

                test1 = new(vinf_DRV,vinf_MON,vinf_REF);
                test2 = new(vinf_DRV,vinf_MON,vinf_REF);
                test3 = new(vinf_DRV,vinf_MON,vinf_REF);
                test4 = new(vinf_DRV,vinf_MON,vinf_REF);
                test5 = new(vinf_DRV,vinf_MON,vinf_REF);
        endfunction

        task run();

                $display("TEST CASE 1 : BASE TEST");
                test1.env = env;
                test1.run();

                $display("TEST CASE 2 : WRITE FIRST");
                test2.env = env;
                test2.run();

                $display("TEST CASE 3 : READ FIRST");
                test3.env = env;
                test3.run();

                $display("TEST CASE 4 : WRITE = 0 READ = 0");
                test4.env = env;
                test4.run();

                $display("TEST CASE 5 : WRITE = 1 READ = 1");
                test5.env = env;
                test5.run();

        endtask

endclass
