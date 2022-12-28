`timescale 1ns / 1ps

module mux (input in1, in2,
            input sel,
            output reg out);
      
    always @ (*) begin
        out = sel ? in2 : in1;
    end   
            
endmodule
