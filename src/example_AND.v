module example_and2 (
    input wire data_a,
    input wire CLK,
    input wire data_b,
    output wire data_o
);
reg out_;
  always@(posedge CLK) 
  begin
    out_ <= data_a & data_b;
  end
assign data_o = out_;
endmodule
