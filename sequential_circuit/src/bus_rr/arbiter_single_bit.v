`timescale 1ns / 1ps

module arbiter_single_bit(
    input   c_in,
    input   g_in_pre,
    input   pri_sel,
    output  g_out
);
reg g_out_reg;

wire c_and_gpre;
assign c_and_gpre = c_in & (~g_in_pre);
always@(*)
begin
   g_out_reg = pri_sel?c_in:c_and_gpre;
end
assign g_out  = g_out_reg;    

endmodule
