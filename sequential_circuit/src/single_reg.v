`timescale 1ns / 1ps

module single_reg#(parameter DATA_TYPE=16)
(
    input                  clk,
    
    input  [DATA_TYPE-1:0] data_in,
    output [DATA_TYPE-1:0] data_out
    );
    reg [DATA_TYPE-1:0] data_out_reg;
    always@(posedge clk)
    begin
        data_out_reg <= data_in;
    end
    assign data_out = data_out_reg;

endmodule
