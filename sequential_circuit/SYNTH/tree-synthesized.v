/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP1
// Date      : Thu Nov 19 13:40:33 2020
/////////////////////////////////////////////////////////////


module selecter_LEN16_2 ( a, b, out );
  input [15:0] a;
  input [15:0] b;
  output [15:0] out;
  wire   n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31;

  AND2_X1 U32 ( .A1(b[0]), .A2(a[0]), .Z(out[0]) );
  INV_X1 U1 ( .I(n25), .ZN(out[1]) );
  INV_X1 U2 ( .I(n24), .ZN(out[2]) );
  INV_X1 U3 ( .I(n23), .ZN(out[3]) );
  INV_X1 U4 ( .I(n22), .ZN(out[4]) );
  INV_X1 U5 ( .I(n21), .ZN(out[5]) );
  INV_X1 U6 ( .I(n20), .ZN(out[6]) );
  INV_X1 U7 ( .I(n19), .ZN(out[7]) );
  INV_X1 U8 ( .I(n18), .ZN(out[8]) );
  INV_X1 U9 ( .I(n17), .ZN(out[9]) );
  INV_X1 U10 ( .I(n31), .ZN(out[10]) );
  INV_X1 U11 ( .I(n30), .ZN(out[11]) );
  INV_X1 U12 ( .I(n29), .ZN(out[12]) );
  INV_X1 U13 ( .I(n28), .ZN(out[13]) );
  INV_X1 U14 ( .I(n27), .ZN(out[14]) );
  INV_X1 U15 ( .I(n26), .ZN(out[15]) );
  AOI22_X1 U16 ( .A1(a[1]), .A2(n16), .B1(b[1]), .B2(a[0]), .ZN(n25) );
  AOI22_X1 U17 ( .A1(a[2]), .A2(n16), .B1(b[2]), .B2(a[0]), .ZN(n24) );
  AOI22_X1 U18 ( .A1(a[3]), .A2(n16), .B1(b[3]), .B2(a[0]), .ZN(n23) );
  AOI22_X1 U19 ( .A1(a[4]), .A2(n16), .B1(b[4]), .B2(a[0]), .ZN(n22) );
  AOI22_X1 U20 ( .A1(a[5]), .A2(n16), .B1(b[5]), .B2(a[0]), .ZN(n21) );
  AOI22_X1 U21 ( .A1(a[6]), .A2(n16), .B1(b[6]), .B2(a[0]), .ZN(n20) );
  AOI22_X1 U22 ( .A1(a[7]), .A2(n16), .B1(b[7]), .B2(a[0]), .ZN(n19) );
  AOI22_X1 U23 ( .A1(a[8]), .A2(n16), .B1(b[8]), .B2(a[0]), .ZN(n18) );
  AOI22_X1 U24 ( .A1(a[9]), .A2(n16), .B1(b[9]), .B2(a[0]), .ZN(n17) );
  AOI22_X1 U25 ( .A1(a[10]), .A2(n16), .B1(b[10]), .B2(a[0]), .ZN(n31) );
  AOI22_X1 U26 ( .A1(a[11]), .A2(n16), .B1(b[11]), .B2(a[0]), .ZN(n30) );
  AOI22_X1 U27 ( .A1(a[12]), .A2(n16), .B1(b[12]), .B2(a[0]), .ZN(n29) );
  AOI22_X1 U28 ( .A1(a[13]), .A2(n16), .B1(b[13]), .B2(a[0]), .ZN(n28) );
  AOI22_X1 U29 ( .A1(a[14]), .A2(n16), .B1(b[14]), .B2(a[0]), .ZN(n27) );
  AOI22_X1 U30 ( .A1(a[15]), .A2(n16), .B1(b[15]), .B2(a[0]), .ZN(n26) );
  INV_X1 U31 ( .I(a[0]), .ZN(n16) );
endmodule


module selecter_LEN16_0 ( a, b, out );
  input [15:0] a;
  input [15:0] b;
  output [15:0] out;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n18,
         n19;

  AND2_X1 U32 ( .A1(b[0]), .A2(n1), .Z(out[0]) );
  INV_X1 U1 ( .I(n8), .ZN(out[1]) );
  AOI22_X1 U2 ( .A1(a[1]), .A2(n19), .B1(b[1]), .B2(n1), .ZN(n8) );
  INV_X1 U3 ( .I(n9), .ZN(out[2]) );
  AOI22_X1 U4 ( .A1(a[2]), .A2(n19), .B1(b[2]), .B2(n1), .ZN(n9) );
  INV_X1 U5 ( .I(n10), .ZN(out[3]) );
  AOI22_X1 U6 ( .A1(a[3]), .A2(n19), .B1(b[3]), .B2(n1), .ZN(n10) );
  INV_X1 U7 ( .I(n11), .ZN(out[4]) );
  AOI22_X1 U8 ( .A1(a[4]), .A2(n19), .B1(b[4]), .B2(n1), .ZN(n11) );
  INV_X1 U9 ( .I(n12), .ZN(out[5]) );
  AOI22_X1 U10 ( .A1(a[5]), .A2(n19), .B1(b[5]), .B2(n1), .ZN(n12) );
  INV_X1 U11 ( .I(n13), .ZN(out[6]) );
  AOI22_X1 U12 ( .A1(a[6]), .A2(n19), .B1(b[6]), .B2(n1), .ZN(n13) );
  INV_X1 U13 ( .I(n14), .ZN(out[7]) );
  AOI22_X1 U14 ( .A1(a[7]), .A2(n19), .B1(b[7]), .B2(n1), .ZN(n14) );
  INV_X1 U15 ( .I(n15), .ZN(out[8]) );
  AOI22_X1 U16 ( .A1(a[8]), .A2(n19), .B1(b[8]), .B2(n1), .ZN(n15) );
  INV_X1 U17 ( .I(n18), .ZN(out[9]) );
  AOI22_X1 U18 ( .A1(a[9]), .A2(n19), .B1(b[9]), .B2(n1), .ZN(n18) );
  INV_X1 U19 ( .I(n2), .ZN(out[10]) );
  AOI22_X1 U20 ( .A1(a[10]), .A2(n19), .B1(b[10]), .B2(n1), .ZN(n2) );
  INV_X1 U21 ( .I(n3), .ZN(out[11]) );
  AOI22_X1 U22 ( .A1(a[11]), .A2(n19), .B1(b[11]), .B2(n1), .ZN(n3) );
  INV_X1 U23 ( .I(n4), .ZN(out[12]) );
  AOI22_X1 U24 ( .A1(a[12]), .A2(n19), .B1(b[12]), .B2(n1), .ZN(n4) );
  INV_X1 U25 ( .I(n5), .ZN(out[13]) );
  AOI22_X1 U26 ( .A1(a[13]), .A2(n19), .B1(b[13]), .B2(n1), .ZN(n5) );
  INV_X1 U27 ( .I(n6), .ZN(out[14]) );
  AOI22_X1 U28 ( .A1(a[14]), .A2(n19), .B1(b[14]), .B2(n1), .ZN(n6) );
  INV_X1 U29 ( .I(n7), .ZN(out[15]) );
  AOI22_X1 U30 ( .A1(a[15]), .A2(n19), .B1(b[15]), .B2(n1), .ZN(n7) );
  INV_X1 U31 ( .I(n1), .ZN(n19) );
  BUF_X2 U33 ( .I(a[0]), .Z(n1) );
endmodule


module selecter_LEN16_1 ( a, b, out );
  input [15:0] a;
  input [15:0] b;
  output [15:0] out;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n17
;

  AND2_X1 U32 ( .A1(b[0]), .A2(a[0]), .Z(out[0]) );
  INV_X1 U1 ( .I(n7), .ZN(out[1]) );
  INV_X1 U2 ( .I(n8), .ZN(out[2]) );
  INV_X1 U3 ( .I(n9), .ZN(out[3]) );
  INV_X1 U4 ( .I(n10), .ZN(out[4]) );
  INV_X1 U5 ( .I(n11), .ZN(out[5]) );
  INV_X1 U6 ( .I(n12), .ZN(out[6]) );
  INV_X1 U7 ( .I(n13), .ZN(out[7]) );
  INV_X1 U8 ( .I(n14), .ZN(out[8]) );
  INV_X1 U9 ( .I(n15), .ZN(out[9]) );
  INV_X1 U10 ( .I(n1), .ZN(out[10]) );
  INV_X1 U11 ( .I(n2), .ZN(out[11]) );
  INV_X1 U12 ( .I(n3), .ZN(out[12]) );
  INV_X1 U13 ( .I(n4), .ZN(out[13]) );
  INV_X1 U14 ( .I(n5), .ZN(out[14]) );
  INV_X1 U15 ( .I(n6), .ZN(out[15]) );
  AOI22_X1 U16 ( .A1(a[1]), .A2(n17), .B1(b[1]), .B2(a[0]), .ZN(n7) );
  AOI22_X1 U17 ( .A1(a[2]), .A2(n17), .B1(b[2]), .B2(a[0]), .ZN(n8) );
  AOI22_X1 U18 ( .A1(a[3]), .A2(n17), .B1(b[3]), .B2(a[0]), .ZN(n9) );
  AOI22_X1 U19 ( .A1(a[4]), .A2(n17), .B1(b[4]), .B2(a[0]), .ZN(n10) );
  AOI22_X1 U20 ( .A1(a[5]), .A2(n17), .B1(b[5]), .B2(a[0]), .ZN(n11) );
  AOI22_X1 U21 ( .A1(a[6]), .A2(n17), .B1(b[6]), .B2(a[0]), .ZN(n12) );
  AOI22_X1 U22 ( .A1(a[7]), .A2(n17), .B1(b[7]), .B2(a[0]), .ZN(n13) );
  AOI22_X1 U23 ( .A1(a[8]), .A2(n17), .B1(b[8]), .B2(a[0]), .ZN(n14) );
  AOI22_X1 U24 ( .A1(a[9]), .A2(n17), .B1(b[9]), .B2(a[0]), .ZN(n15) );
  AOI22_X1 U25 ( .A1(a[10]), .A2(n17), .B1(b[10]), .B2(a[0]), .ZN(n1) );
  AOI22_X1 U26 ( .A1(a[11]), .A2(n17), .B1(b[11]), .B2(a[0]), .ZN(n2) );
  AOI22_X1 U27 ( .A1(a[12]), .A2(n17), .B1(b[12]), .B2(a[0]), .ZN(n3) );
  AOI22_X1 U28 ( .A1(a[13]), .A2(n17), .B1(b[13]), .B2(a[0]), .ZN(n4) );
  AOI22_X1 U29 ( .A1(a[14]), .A2(n17), .B1(b[14]), .B2(a[0]), .ZN(n5) );
  AOI22_X1 U30 ( .A1(a[15]), .A2(n17), .B1(b[15]), .B2(a[0]), .ZN(n6) );
  INV_X1 U31 ( .I(a[0]), .ZN(n17) );
endmodule


module tree_NUM4 ( clk, in, sum );
  input [63:0] in;
  output [15:0] sum;
  input clk;
  wire   wire_inner_65__15_, wire_inner_65__14_, wire_inner_65__13_,
         wire_inner_65__12_, wire_inner_65__11_, wire_inner_65__10_,
         wire_inner_65__9_, wire_inner_65__8_, wire_inner_65__7_,
         wire_inner_65__6_, wire_inner_65__5_, wire_inner_65__4_,
         wire_inner_65__3_, wire_inner_65__2_, wire_inner_65__1_,
         wire_inner_65__0_, wire_inner_64__15_, wire_inner_64__14_,
         wire_inner_64__13_, wire_inner_64__12_, wire_inner_64__11_,
         wire_inner_64__10_, wire_inner_64__9_, wire_inner_64__8_,
         wire_inner_64__7_, wire_inner_64__6_, wire_inner_64__5_,
         wire_inner_64__4_, wire_inner_64__3_, wire_inner_64__2_,
         wire_inner_64__1_, wire_inner_64__0_;

  selecter_LEN16_2 genblk3_0__level0 ( .a(in[15:0]), .b(in[31:16]), .out({
        wire_inner_64__15_, wire_inner_64__14_, wire_inner_64__13_, 
        wire_inner_64__12_, wire_inner_64__11_, wire_inner_64__10_, 
        wire_inner_64__9_, wire_inner_64__8_, wire_inner_64__7_, 
        wire_inner_64__6_, wire_inner_64__5_, wire_inner_64__4_, 
        wire_inner_64__3_, wire_inner_64__2_, wire_inner_64__1_, 
        wire_inner_64__0_}) );
  selecter_LEN16_1 genblk3_1__level0 ( .a(in[47:32]), .b(in[63:48]), .out({
        wire_inner_65__15_, wire_inner_65__14_, wire_inner_65__13_, 
        wire_inner_65__12_, wire_inner_65__11_, wire_inner_65__10_, 
        wire_inner_65__9_, wire_inner_65__8_, wire_inner_65__7_, 
        wire_inner_65__6_, wire_inner_65__5_, wire_inner_65__4_, 
        wire_inner_65__3_, wire_inner_65__2_, wire_inner_65__1_, 
        wire_inner_65__0_}) );
  selecter_LEN16_0 genblk5_0__level1 ( .a({wire_inner_64__15_, 
        wire_inner_64__14_, wire_inner_64__13_, wire_inner_64__12_, 
        wire_inner_64__11_, wire_inner_64__10_, wire_inner_64__9_, 
        wire_inner_64__8_, wire_inner_64__7_, wire_inner_64__6_, 
        wire_inner_64__5_, wire_inner_64__4_, wire_inner_64__3_, 
        wire_inner_64__2_, wire_inner_64__1_, wire_inner_64__0_}), .b({
        wire_inner_65__15_, wire_inner_65__14_, wire_inner_65__13_, 
        wire_inner_65__12_, wire_inner_65__11_, wire_inner_65__10_, 
        wire_inner_65__9_, wire_inner_65__8_, wire_inner_65__7_, 
        wire_inner_65__6_, wire_inner_65__5_, wire_inner_65__4_, 
        wire_inner_65__3_, wire_inner_65__2_, wire_inner_65__1_, 
        wire_inner_65__0_}), .out(sum) );
endmodule

