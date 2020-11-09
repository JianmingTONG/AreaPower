module example_and2 (
    input wire data_a,
    input wire data_b,
    output wire data_o
);
  assign data_o = data_a & data_b;
endmodule
