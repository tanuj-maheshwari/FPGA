module logic_tile (out, clock, in1, in2, in3, in4, in5);

    input clock, in1, in2, in3, in4, in5;
    output out;

    reg lut, out;
    reg [32:0] mem;

    reg [1:5] control;

    always @(*) begin
        control = {in5, in4, in3, in2, in1};

        lut = mem[control];
    end

    reg q;

    initial q = 0;

    always @(posedge clock) begin
        q <= lut;
    end

    always @(*) begin
        case(mem[32])
            1'b0: out = lut;
            1'b1: out = q;
            default: out = 1'bx;
        endcase
    end

endmodule

module switch_box (out, in);

    input [3:0] in;
    output [3:0] out;
    reg [3:0] out;

    reg [15:0] configure;

    always @(*) begin
        out[0] = (configure[0] & in[0]) | (configure[1] & in[1]) | (configure[2] & in[2]) | (configure[3] & in[3]);
        out[1] = (configure[4] & in[0]) | (configure[5] & in[1]) | (configure[6] & in[2]) | (configure[7] & in[3]);
        out[2] = (configure[8] & in[0]) | (configure[9] & in[1]) | (configure[10] & in[2]) | (configure[11] & in[3]);
        out[3] = (configure[12] & in[0]) | (configure[13] & in[1]) | (configure[14] & in[2]) | (configure[15] & in[3]);
    end

endmodule

module FPGA (out, in, clock);

    input [0:10] in;
    output [0:4] out;
    input clock;

    wire lt1_out, lt2_out, lt3_out, lt4_out, lt5_out, lt6_out, lt7_out, lt8_out, lt9_out, lt10_out, lt11_out;
    wire [3:0] sb1_out, sb2_out, sb3_out, sb4_out, sb5_out, sb6_out, sb7_out, sb8_out, sb9_out, sb10_out, sb11_out, sb12_out, sb13_out, sb14_out, sb15_out, sb16_out, sb17_out, sb18_out, sb19_out, sb20_out;

    switch_box sb1_inst(sb1_out, {in[3], in[2], in[5], in[4]});
    switch_box sb2_inst(sb2_out, {lt2_out, lt1_out, in[1], in[0]});
    switch_box sb3_inst(sb3_out, {lt2_out, lt5_out, in[5], in[4]});
    switch_box sb4_inst(sb4_out, {in[1], in[0], lt2_out, in[9]});
    switch_box sb5_inst(sb5_out, {lt4_out, lt3_out, in[1], in[0]});
    switch_box sb6_inst(sb6_out, {lt6_out, lt5_out, in[5], in[4]});
    switch_box sb7_inst(sb7_out, {in[1], in[0], lt2_out, sb5_out[1]});
    switch_box sb8_inst(sb8_out, {lt6_out, lt5_out, in[5], in[4]});
    switch_box sb9_inst(sb9_out, {in[1], in[0], lt2_out, lt7_out});
    switch_box sb10_inst(sb10_out, {in[1], in[0], lt2_out, in[8]});
    switch_box sb11_inst(sb11_out, {lt10_out, lt2_out, lt4_out, lt3_out});
    switch_box sb12_inst(sb12_out, {in[1], in[0], lt7_out, in[3]});
    switch_box sb13_inst(sb13_out, {lt9_out, lt8_out, lt5_out, lt4_out});
    switch_box sb14_inst(sb14_out, {lt8_out, lt6_out, lt3_out, lt5_out});
    switch_box sb15_inst(sb15_out, {in[0], lt10_out, lt9_out, lt7_out});
    switch_box sb16_inst(sb16_out, {in[0], lt7_out, lt6_out, lt5_out});
    switch_box sb17_inst(sb17_out, {in[0], lt7_out, lt6_out, lt5_out});
    switch_box sb18_inst(sb18_out, {in[1], in[0], lt6_out, lt3_out});
    switch_box sb19_inst(sb19_out, {lt6_out, lt5_out, lt4_out, lt3_out});
    switch_box sb20_inst(sb20_out, {in[2], in[1], in[0], lt7_out});


    logic_tile lt1_inst(lt1_out, clock, in[0], in[1], in[0], in[1], in[10]);
    logic_tile lt2_inst(lt2_out, clock, in[2], in[3], in[6], in[7], in[10]);
    logic_tile lt3_inst(lt3_out, clock, sb1_out[0], sb1_out[1], in[6], in[7], in[10]);
    logic_tile lt4_inst(lt4_out, clock, in[6], in[7], in[2], in[3], in[10]);
    logic_tile lt5_inst(lt5_out, clock, sb3_out[0], sb3_out[1], sb2_out[0], sb2_out[1], sb4_out[0]);
    logic_tile lt6_inst(lt6_out, clock, sb6_out[0], sb6_out[1], sb5_out[0], sb7_out[0], sb4_out[0]);
    logic_tile lt7_inst(lt7_out, clock, sb8_out[0], sb8_out[1], sb9_out[0], sb9_out[1], sb10_out[0]);
    logic_tile lt8_inst(lt8_out, clock, sb11_out[2], sb11_out[3], sb16_out[0], sb16_out[1], sb16_out[2]);
    logic_tile lt9_inst(lt9_out, clock, sb11_out[0], sb11_out[1], sb17_out[0], sb17_out[1], sb17_out[2]);
    logic_tile lt10_inst(lt10_out, clock, sb18_out[0], sb13_out[0], sb13_out[1], sb18_out[1], sb12_out[0]);
    logic_tile lt11_inst(lt11_out, clock, sb19_out[0], sb19_out[1], sb19_out[2], sb19_out[3], sb20_out[0]);


    assign out = {lt11_out, sb15_out[1], sb15_out[0], sb14_out[1], sb14_out[0]};

endmodule

