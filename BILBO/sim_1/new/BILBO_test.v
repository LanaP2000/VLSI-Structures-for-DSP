`timescale 1ns / 1ps

module BILBO_test();

reg Clk;
reg LdA, LdB, LdC;
reg B1, B2, Si;
wire So;
reg [3:0] DBus;
wire [3:0] Output;
reg [4:0] Sig;

parameter [0:12] test_vector = 13'b1000110000000;
parameter [4:0] test_result = 5'b01011;

integer i;

    initial begin
        B1 = 1'b0;
        B2 = 1'b0;
        Si = 1'b0;
        Clk = 1'b1;
        Sig = 0;
    end
    
    always #5 Clk = ~Clk;
    
    BILBO_System Sys (Clk, LdA, LdB, LdC, B1, B2, Si, So, DBus, Output);

    always begin
        B1 <= 1'b0;
        B2 <= 1'b0;
        begin : xhdl_2 // Shift in Test Vector
            for (i = 0; i <= 12; i = i + 1) begin
                Si <= test_vector[i];
                @(posedge Clk);
            end
        end
        B1 <= 1'b0;
        B2 <= 1'b1; 
        begin : xhdl_3 // Use PRPG and MISR
            integer i;
            for (i = 0; i <= 3; i = i + 1) begin
                @(posedge Clk);
            end
        end
        B1 <= 1'b0;
        B2 <= 1'b0;
        begin : xhdl_4 // Shift Signature Out
            integer i;
            for (i = 0; i <= 4; i = i + 1) begin
                $display("I is %d, So is %d", i, So);
                $display($time);
                @(posedge Clk);
                Sig <= {So, Sig[4:1]};
                
            end
        end
        @(posedge Clk); @(posedge Clk);
        if (Sig == test_result) begin // Compare Signature
            $display("System passed test. (NO ERROR)");
        end
        else begin
            $display("System did not pass test! (ERROR)");
        end
    end

endmodule
