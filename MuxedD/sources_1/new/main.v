`timescale 1ns / 1ps

module main (clk);

input clk;

reg GND, VDD, CK, G0, G1, G2, G3;
wire G17;

s27 CKT (GND, VDD, CK, G0, G1, G2, G3, G17);

endmodule
