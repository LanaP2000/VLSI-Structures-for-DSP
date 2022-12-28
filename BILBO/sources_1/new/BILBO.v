`timescale 1ns / 1ps

module BILBO (Clk, CE, B1, B2, Si, So, Z, Q);
    
parameter [2:0] NBITS = 4;
input Clk, CE;
input B1, B2, Si;
output So;
input [1:NBITS] Z;
inout [1:NBITS] Q;

reg [1:NBITS] Q_tmp;
wire FB;
wire [1:0] mode;

    initial begin
        Q_tmp = 0;
    end
    
    assign mode = {B1, B2};
    assign Q = Q_tmp;
    assign FB = Q[1] ^ Q[NBITS];
    
    always @(Clk) begin : xhdl_4
        if (Clk == 1'b1 & CE == 1'b1) begin
            case (mode)
                2'b00: begin // Shift register mode
                    Q_tmp <= {Si, Q[1:NBITS-1]};
                end
                2'b01: begin // Pseudo Random Pattern Generator mode
                    Q_tmp <= {FB, Q[1:NBITS-1]};
                end
                2'b10: begin // Normal Operation mode
                    Q_tmp <= Z;
                end
                2'b11: begin // Multiple Input Signature Register mode
                    Q_tmp <= Z[1:NBITS] ^ ({FB, Q[1:NBITS-1]});
                end
            endcase
        end
    end
    
    assign So = Q[NBITS];
    
endmodule
