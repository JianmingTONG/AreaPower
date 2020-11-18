`timescale 1ns / 1ps

module single_multiplexer#(parameter NUM_PES=16, DATA_TYPE=8, NUM_SEL=$clog2(NUM_PES))
(
    input                          clk,
    input  [NUM_SEL-1:0]           sel_in,
    input  [NUM_PES*DATA_TYPE-1:0] data_in,
    output [DATA_TYPE-1:0]         data_out
    );
    reg [DATA_TYPE-1:0] data_out_reg;
    reg [DATA_TYPE-1:0] temp_data;
    always@(*)
    begin
        temp_data = data_in >> sel_in;
    end

    always@(posedge clk)
    begin
        
        data_out_reg <= temp_data;
    end
    assign data_out = data_out_reg;

endmodule
