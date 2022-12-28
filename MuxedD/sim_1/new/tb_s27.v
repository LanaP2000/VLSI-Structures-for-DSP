`timescale 1ns / 1ps

module tb_s27();

parameter ClockPeriod = 10;

// System inputs and output
reg GND, VDD, CK, G0, G1, G2, G3;
wire G17;

// Scan chain inputs
reg SE, SI0, SI1, SI2;

s27 DUT (.GND(GND), .VDD(VDD), .CK(CK), .G0(G0), .G1(G1), .G2(G2), .G3(G3), 
         .SE(SE), .SI0(SI0), .SI1(SI1), .SI2(SI2), .G17(G17));

    initial begin : ClockGenerator
        CK = 1'b0;
        forever #(ClockPeriod / 2) CK = ~CK;
    end
    
    initial begin : TestVectorGenerator
        GND = 1'b0; VDD = 1'b1; G0 = 1'b0; G1 = 1'b1; G2 = 1'b0; G3 = 1'b0;
        @(posedge CK) SE = 1'b1; SI0 = 1'b0; SI1 = 1'b1; SI2 = 1'b1;
        @(posedge CK); @(posedge CK); 
        @(posedge CK); @(posedge CK);
        @(posedge CK) SI0 = 1'b1; SI1 = 1'b0; SI2 = 1'b1;
        @(posedge CK); @(posedge CK); 
        @(posedge CK); @(posedge CK);
        $finish;
    end

endmodule
