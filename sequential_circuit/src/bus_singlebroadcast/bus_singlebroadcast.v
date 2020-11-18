`timescale 1ns / 1ps

// NUM_PES should >= 2
module bus_singlebroadcast#(parameter NUM_PES=4, DATA_TYPE=16, NUM_ITER=$clog2(NUM_PES))
(
    input                             clk,
    
    input  [DATA_TYPE-1:0]            data_in,
    output [NUM_PES*DATA_TYPE-1:0]    data_out,
    
    input                             req,
    output                            grant
    );
reg                                  grant_reg;
reg  [DATA_TYPE-1:0]                 data_out_reg;

wire [DATA_TYPE-1:0]                 value;
assign value = (req)?data_in:{DATA_TYPE{1'bx}};


always@(posedge clk)
begin
    data_out_reg <= value;
    grant_reg    <= (req)?1'b1:1'b0;
end

genvar i;
generate
for(i=0; i< NUM_PES;i = i +1)
begin
    assign data_out[(i+1)*DATA_TYPE-1:i*DATA_TYPE] = data_out_reg;
end
endgenerate

assign grant = grant_reg;

endmodule
