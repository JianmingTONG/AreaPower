`timescale 1ns / 1ps


module linear_dist#(parameter NUM_PES=4, DATA_TYPE=16)
(
    input                         clk,
    
    input  [NUM_PES*DATA_TYPE-1:0] data_in,
    output [DATA_TYPE-1:0]         data_out
    );

    wire [(NUM_PES-1)*DATA_TYPE-1:0]   adder_out;


    adder#(.LEN(DATA_TYPE)) linear_add_first(.clk(clk), .a(data_in[DATA_TYPE-1:0]), .b(data_in[2*DATA_TYPE-1:DATA_TYPE]), .out(adder_out[DATA_TYPE-1:0]));
    genvar i;
    generate
        for (i=2; i < NUM_PES; i=i+1) begin: gen_linear_adder
            adder#(.LEN(DATA_TYPE)) linear_add(.clk(clk), .a(data_in[(i+1)*DATA_TYPE-1:i*DATA_TYPE]), .b(adder_out[(i-1)*DATA_TYPE-1:(i-2)*DATA_TYPE]), .out(adder_out[i*DATA_TYPE-1:(i-1)*DATA_TYPE]) );
        end
    endgenerate
  
    assign data_out = adder_out[(NUM_PES-1)*DATA_TYPE-1:(NUM_PES-2)*DATA_TYPE];

endmodule



module adder#(parameter LEN = 16)(
    input  clk,
    input  [LEN-1:0] a,
    input  [LEN-1:0] b,
    output [LEN-1:0]  out
    );
    reg  [LEN-1:0]  out_inner;
    always@(posedge clk)
    begin
         out_inner <= a[0]? a : b;
    end
    
    assign out = out_inner;
endmodule
