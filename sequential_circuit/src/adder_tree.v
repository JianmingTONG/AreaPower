

////////////////////////////// adder tree
module adder_tree#(parameter NUM = 4096, LEN = 16, LEVEL = $clog2(NUM) )(
    input  clk,
    input  [NUM*LEN-1:0] in,
    output [LEN-1:0] sum
    );
    
    // 将输入长向量还原为矩阵形式。高位是右侧的C&S
    wire  [LEN-1:0] in_inner[NUM-1:0]; 
    reg   [LEN-1:0] sum_inner;
    
    genvar i;
    for ( i = 0; i < NUM ; i = i + 1)
    begin
        assign in_inner[i]=in[(i+1)*LEN-1:i*LEN];
    end
    
    
    // 计算各个级别的比较器数目，将各个级别的首地址记录在一个单独的变量之中
    // START_LEVELx             记录了LEVELx输入线的起始index。 
    // NUM_INPUT_LEVELx         记录LEVELx的输入线数目。
    // IS_ODD_NUM_INPUT_LEVELx  记录了LEVELx的输入线总数是否为奇数？
    // DIV2_NUM_LEVELx          为LEVELx输入线数目直接右移1位。（中间变量）
    // NUM_ADDER_LEVELx         记录了LEVELx的ADDER个数,同时也是LEVEL(x+1)的输入线数目。
         
    localparam   START_LEVEL0             =  0;
    localparam   NUM_INPUT_LEVEL0         =  NUM;
    localparam   IS_ODD_NUM_INPUT_LEVEL0  =  NUM_INPUT_LEVEL0[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL0    =  NUM_INPUT_LEVEL0>>1;
    localparam   NUM_ADDER_LEVEL0         =  (NUM_INPUT_LEVEL0==1)?0:DIV2_NUM_INPUT_LEVEL0 + IS_ODD_NUM_INPUT_LEVEL0;
    
    localparam   START_LEVEL1             =  START_LEVEL0 + NUM_INPUT_LEVEL0*LEN;
    localparam   NUM_INPUT_LEVEL1         =  NUM_ADDER_LEVEL0;
    localparam   IS_ODD_NUM_INPUT_LEVEL1  =  NUM_INPUT_LEVEL1[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL1    =  NUM_INPUT_LEVEL1>>1;
    localparam   NUM_ADDER_LEVEL1         =  (NUM_INPUT_LEVEL1==1)?0:DIV2_NUM_INPUT_LEVEL1 + IS_ODD_NUM_INPUT_LEVEL1;
    
    localparam   START_LEVEL2             =  START_LEVEL1 + NUM_INPUT_LEVEL1*(LEN+1);
    localparam   NUM_INPUT_LEVEL2         =  NUM_ADDER_LEVEL1;
    localparam   IS_ODD_NUM_INPUT_LEVEL2  =  NUM_INPUT_LEVEL2[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL2    =  NUM_INPUT_LEVEL2>>1;
    localparam   NUM_ADDER_LEVEL2         =  (NUM_INPUT_LEVEL2==1)?0:DIV2_NUM_INPUT_LEVEL2 + IS_ODD_NUM_INPUT_LEVEL2;
    
    localparam   START_LEVEL3             =  START_LEVEL2 + NUM_INPUT_LEVEL2;
    localparam   NUM_INPUT_LEVEL3         =  NUM_ADDER_LEVEL2;
    localparam   IS_ODD_NUM_INPUT_LEVEL3  =  NUM_INPUT_LEVEL3[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL3    =  NUM_INPUT_LEVEL3>>1;
    localparam   NUM_ADDER_LEVEL3         =  (NUM_INPUT_LEVEL3==1)?0:DIV2_NUM_INPUT_LEVEL3 + IS_ODD_NUM_INPUT_LEVEL3;
    
    localparam   START_LEVEL4             =  START_LEVEL3 + NUM_INPUT_LEVEL3;
    localparam   NUM_INPUT_LEVEL4         =  NUM_ADDER_LEVEL3;
    localparam   IS_ODD_NUM_INPUT_LEVEL4  =  NUM_INPUT_LEVEL4[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL4    =  NUM_INPUT_LEVEL4>>1;
    localparam   NUM_ADDER_LEVEL4         =  (NUM_INPUT_LEVEL4==1)?0:DIV2_NUM_INPUT_LEVEL4 + IS_ODD_NUM_INPUT_LEVEL4;
    
    localparam   START_LEVEL5             =  START_LEVEL4 + NUM_INPUT_LEVEL4;
    localparam   NUM_INPUT_LEVEL5         =  NUM_ADDER_LEVEL4;
    localparam   IS_ODD_NUM_INPUT_LEVEL5  =  NUM_INPUT_LEVEL5[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL5    =  NUM_INPUT_LEVEL5>>1;
    localparam   NUM_ADDER_LEVEL5         =  (NUM_INPUT_LEVEL5==1)?0:DIV2_NUM_INPUT_LEVEL5 + IS_ODD_NUM_INPUT_LEVEL5;
    
    localparam   START_LEVEL6             =  START_LEVEL5 + NUM_INPUT_LEVEL5;
    localparam   NUM_INPUT_LEVEL6         =  NUM_ADDER_LEVEL5;
    localparam   IS_ODD_NUM_INPUT_LEVEL6  =  NUM_INPUT_LEVEL6[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL6    =  NUM_INPUT_LEVEL6>>1;
    localparam   NUM_ADDER_LEVEL6         =  (NUM_INPUT_LEVEL6==1)?0:DIV2_NUM_INPUT_LEVEL6 + IS_ODD_NUM_INPUT_LEVEL6;
    
    localparam   START_LEVEL7             =  START_LEVEL6 + NUM_INPUT_LEVEL6;
    localparam   NUM_INPUT_LEVEL7         =  NUM_ADDER_LEVEL6;
    localparam   IS_ODD_NUM_INPUT_LEVEL7  =  NUM_INPUT_LEVEL7[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL7    =  NUM_INPUT_LEVEL7>>1;
    localparam   NUM_ADDER_LEVEL7         =  (NUM_INPUT_LEVEL7==1)?0:DIV2_NUM_INPUT_LEVEL7 + IS_ODD_NUM_INPUT_LEVEL7;
    
    localparam   START_LEVEL8             =  START_LEVEL7 + NUM_INPUT_LEVEL7;
    localparam   NUM_INPUT_LEVEL8         =  NUM_ADDER_LEVEL7;
    localparam   IS_ODD_NUM_INPUT_LEVEL8  =  NUM_INPUT_LEVEL8[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL8    =  NUM_INPUT_LEVEL8>>1;
    localparam   NUM_ADDER_LEVEL8         =  (NUM_INPUT_LEVEL8==1)?0:DIV2_NUM_INPUT_LEVEL8 + IS_ODD_NUM_INPUT_LEVEL8;
    
    localparam   START_LEVEL9             =  START_LEVEL8 + NUM_INPUT_LEVEL8;
    localparam   NUM_INPUT_LEVEL9         =  NUM_ADDER_LEVEL8;
    localparam   IS_ODD_NUM_INPUT_LEVEL9  =  NUM_INPUT_LEVEL9[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL9    =  NUM_INPUT_LEVEL9>>1;
    localparam   NUM_ADDER_LEVEL9         =  (NUM_INPUT_LEVEL9==1)?0:DIV2_NUM_INPUT_LEVEL9 + IS_ODD_NUM_INPUT_LEVEL9;

    localparam   START_LEVEL10            =  START_LEVEL9 + NUM_INPUT_LEVEL9;
    localparam   NUM_INPUT_LEVEL10        =  NUM_ADDER_LEVEL9;
    localparam   IS_ODD_NUM_INPUT_LEVEL10 =  NUM_INPUT_LEVEL10[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL10   =  NUM_INPUT_LEVEL10>>1;
    localparam   NUM_ADDER_LEVEL10        =  (NUM_INPUT_LEVEL10==1)?0:DIV2_NUM_INPUT_LEVEL10 + IS_ODD_NUM_INPUT_LEVEL10;

    localparam   START_LEVEL11            =  START_LEVEL10 + NUM_INPUT_LEVEL10;
    localparam   NUM_INPUT_LEVEL11        =  NUM_ADDER_LEVEL10;
    localparam   IS_ODD_NUM_INPUT_LEVEL11 =  NUM_INPUT_LEVEL11[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL11   =  NUM_INPUT_LEVEL11>>1;
    localparam   NUM_ADDER_LEVEL11        =  (NUM_INPUT_LEVEL11==1)?0:DIV2_NUM_INPUT_LEVEL11 + IS_ODD_NUM_INPUT_LEVEL11;    
    
    localparam   START_LEVEL12            =  START_LEVEL11 + NUM_INPUT_LEVEL11;
    localparam   NUM_INPUT_LEVEL12        =  NUM_ADDER_LEVEL11;
    localparam   IS_ODD_NUM_INPUT_LEVEL12 =  NUM_INPUT_LEVEL12[0]==1?1:0;
    localparam   DIV2_NUM_INPUT_LEVEL12   =  NUM_INPUT_LEVEL12>>1;
    localparam   NUM_ADDER_LEVEL12        =  (NUM_INPUT_LEVEL12==1)?0:DIV2_NUM_INPUT_LEVEL12 + IS_ODD_NUM_INPUT_LEVEL12;    
    localparam   START_LEVEL13            =  START_LEVEL12 + NUM_INPUT_LEVEL12;

    wire [LEN-1:0] wire_inner[START_LEVEL13-1:0]; //多加的1是最终的输出。
    
    for (i = 0; i < NUM_INPUT_LEVEL0; i = i + 1) 
    begin
       assign wire_inner[i] = in_inner[i];
    end
    
    genvar index_num;
    generate
        
    for (index_num = 0; index_num < NUM_ADDER_LEVEL0-IS_ODD_NUM_INPUT_LEVEL0; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level0(.a(wire_inner[START_LEVEL0 + 2*index_num]),.b(wire_inner[START_LEVEL0+2*index_num+1]),.out(wire_inner[START_LEVEL1+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL0 && (NUM_ADDER_LEVEL0>0))
        adder#(.LEN(LEN)) level0_last(.a(wire_inner[START_LEVEL0+2*(NUM_ADDER_LEVEL0-1)]),.b(0),.out(wire_inner[START_LEVEL1+NUM_ADDER_LEVEL0 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL1-IS_ODD_NUM_INPUT_LEVEL1; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level1(.a(wire_inner[START_LEVEL1+2*index_num]),.b(wire_inner[START_LEVEL1+2*index_num+1]),.out(wire_inner[START_LEVEL2+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL1 && (NUM_ADDER_LEVEL1>0))
        adder#(.LEN(LEN)) level1_last(.a(wire_inner[START_LEVEL1+2*(NUM_ADDER_LEVEL1-1)]),.b(0),.out(wire_inner[START_LEVEL2+NUM_ADDER_LEVEL1 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL2-IS_ODD_NUM_INPUT_LEVEL2; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level2(.a(wire_inner[START_LEVEL2+2*index_num]),.b(wire_inner[START_LEVEL2+2*index_num+1]),.out(wire_inner[START_LEVEL3+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL2 && (NUM_ADDER_LEVEL2>0))
        adder#(.LEN(LEN)) level2_last(.a(wire_inner[START_LEVEL2+2*(NUM_ADDER_LEVEL2-1)]),.b(0),.out(wire_inner[START_LEVEL3+NUM_ADDER_LEVEL2 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL3-IS_ODD_NUM_INPUT_LEVEL3; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level3(.a(wire_inner[START_LEVEL3+2*index_num]),.b(wire_inner[START_LEVEL3+2*index_num+1]),.out(wire_inner[START_LEVEL4+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL3 && (NUM_ADDER_LEVEL3>0))
        adder#(.LEN(LEN)) level3_last(.a(wire_inner[START_LEVEL3+2*(NUM_ADDER_LEVEL3-1)]),.b(0),.out(wire_inner[START_LEVEL4+NUM_ADDER_LEVEL3 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL4-IS_ODD_NUM_INPUT_LEVEL4; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level4(.a(wire_inner[START_LEVEL4+2*index_num]),.b(wire_inner[START_LEVEL4+2*index_num+1]),.out(wire_inner[START_LEVEL5+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL4 && (NUM_ADDER_LEVEL4>0))
        adder#(.LEN(LEN)) level4_last(.a(wire_inner[START_LEVEL4+2*(NUM_ADDER_LEVEL4-1)]),.b(0),.out(wire_inner[START_LEVEL5+NUM_ADDER_LEVEL4 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL5-IS_ODD_NUM_INPUT_LEVEL5; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level5(.a(wire_inner[START_LEVEL5+2*index_num]),.b(wire_inner[START_LEVEL5+2*index_num+1]),.out(wire_inner[START_LEVEL6+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL5 && (NUM_ADDER_LEVEL5>0))
        adder#(.LEN(LEN)) level5_last(.a(wire_inner[START_LEVEL5+2*(NUM_ADDER_LEVEL5-1)]),.b(0),.out(wire_inner[START_LEVEL6+NUM_ADDER_LEVEL5 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL6-IS_ODD_NUM_INPUT_LEVEL6; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level6(.a(wire_inner[START_LEVEL6+2*index_num]),.b(wire_inner[START_LEVEL6+2*index_num+1]),.out(wire_inner[START_LEVEL7+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL6 && (NUM_ADDER_LEVEL6>0))
        adder#(.LEN(LEN)) level6_last(.a(wire_inner[START_LEVEL6+2*(NUM_ADDER_LEVEL6-1)]),.b(0),.out(wire_inner[START_LEVEL7+NUM_ADDER_LEVEL6 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL7-IS_ODD_NUM_INPUT_LEVEL7; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level7(.a(wire_inner[START_LEVEL7+2*index_num]),.b(wire_inner[START_LEVEL7+2*index_num+1]),.out(wire_inner[START_LEVEL8+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL7 && (NUM_ADDER_LEVEL7>0))
        adder#(.LEN(LEN)) level7_last(.a(wire_inner[START_LEVEL7+2*(NUM_ADDER_LEVEL7-1)]),.b(0),.out(wire_inner[START_LEVEL8+NUM_ADDER_LEVEL7 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL8-IS_ODD_NUM_INPUT_LEVEL8; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level8(.a(wire_inner[START_LEVEL8+2*index_num]),.b(wire_inner[START_LEVEL8+2*index_num+1]),.out(wire_inner[START_LEVEL9+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL8 && (NUM_ADDER_LEVEL8>0))
        adder#(.LEN(LEN)) level8_last(.a(wire_inner[START_LEVEL8+2*(NUM_ADDER_LEVEL8-1)]),.b(0),.out(wire_inner[START_LEVEL9+NUM_ADDER_LEVEL8 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL9-IS_ODD_NUM_INPUT_LEVEL9; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level9(.a(wire_inner[START_LEVEL9+2*index_num]),.b(wire_inner[START_LEVEL9+2*index_num+1]),.out(wire_inner[START_LEVEL10+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL9 && (NUM_ADDER_LEVEL9>0))
        adder#(.LEN(LEN)) level9_last(.a(wire_inner[START_LEVEL9+2*(NUM_ADDER_LEVEL9-1)]),.b(0),.out(wire_inner[START_LEVEL10+NUM_ADDER_LEVEL9 - 1]));   
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL10-IS_ODD_NUM_INPUT_LEVEL10; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level10(.a(wire_inner[START_LEVEL10+2*index_num]),.b(wire_inner[START_LEVEL10+2*index_num+1]),.out(wire_inner[START_LEVEL11+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL10 && (NUM_ADDER_LEVEL10>0))
        adder#(.LEN(LEN)) level10_last(.a(wire_inner[START_LEVEL10+2*(NUM_ADDER_LEVEL10-1)]),.b(0),.out(wire_inner[START_LEVEL11+NUM_ADDER_LEVEL10 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL11-IS_ODD_NUM_INPUT_LEVEL11; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level11(.a(wire_inner[START_LEVEL11+2*index_num]),.b(wire_inner[START_LEVEL11+2*index_num+1]),.out(wire_inner[START_LEVEL12+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL11 && (NUM_ADDER_LEVEL11>0))
        adder#(.LEN(LEN)) level11_last(.a(wire_inner[START_LEVEL11+2*(NUM_ADDER_LEVEL11-1)]),.b(0),.out(wire_inner[START_LEVEL12+NUM_ADDER_LEVEL11 - 1]));
    
    for (index_num = 0; index_num < NUM_ADDER_LEVEL12-IS_ODD_NUM_INPUT_LEVEL12; index_num = index_num + 1)
    begin
        adder#(.LEN(LEN)) level12(.a(wire_inner[START_LEVEL12+2*index_num]),.b(wire_inner[START_LEVEL12+2*index_num+1]),.out(wire_inner[START_LEVEL13+index_num]));
    end
    if(IS_ODD_NUM_INPUT_LEVEL12 && (NUM_ADDER_LEVEL12>0))
        adder#(.LEN(LEN)) level12_last(.a(wire_inner[START_LEVEL12+2*(NUM_ADDER_LEVEL12-1)]),.b(0),.out(wire_inner[START_LEVEL13+NUM_ADDER_LEVEL12 - 1]));
    endgenerate
 
    always@*
    begin
        sum_inner = wire_inner[START_LEVEL13-1];
    end
    
    assign sum = sum_inner;
endmodule


module adder#(parameter LEN = 16)(
    input  [LEN-1:0] a,
    input  [LEN-1:0] b,
    output [LEN-1:0]  out
    );
    reg  [LEN-1:0]  out_inner;
    always@*
    begin
        out_inner = a[0]==0? a : b;
    end
    
    assign out = out_inner;
endmodule


