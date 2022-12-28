`timescale 1ns / 1ps

module BILBO_System (Clk, LdA, LdB, LdC, B1, B2, Si, So, DBus, Output);
    
input Clk;
input LdA, LdB, LdC;
input B1, B2, Si;
output So;

input [3:0] DBus;
inout [4:0] Output;
wire [4:0] Output;
wire [4:0] Output_xhdl0;

wire [3:0] Aout, Bout;
wire [4:0] Cin;
wire ACE, BCE, CCE, CB1, Test, S1, S2;

wire [3:0] Sum;

    assign Output = Output_xhdl0;
    assign Test = ~B1 | B2;
    assign ACE = Test | LdA;
    assign BCE = Test | LdB;
    assign CCE = Test | LdC;
    assign CB1 = B1 ^ B2;
    assign Cin = {Carry, Sum};    
    
BILBO #(4) RegA (Clk, ACE, B1, B2, S1, S2, DBus, Aout);

BILBO #(4) RegB (Clk, BCE, B1, B2, Si, S1, DBus, Bout);

BILBO #(5) RegC (Clk, CCE, CB1, B2, S2, So, Cin, Output);
    
Adder4 Adder (Aout, Bout, 1'b0, Sum, Carry);
    
endmodule
