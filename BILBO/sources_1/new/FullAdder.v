`timescale 1ns / 1ps

module FullAdder (input X, Y,
                  input Cin,
                  output Sum,
                  output Cout);
     
    assign #10 Sum = X ^ Y ^ Cin;
    assign #10 Cout = (X & Y) | (X & Cin) | (Y & Cin);   
    
endmodule
