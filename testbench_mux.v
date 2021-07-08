module lab6_tb();

    reg [0:10] in;
    reg clock;
    wire [0:4] out;
    wire [0:3] counter_out = out[1:4];
    wire mux_out = out[0];

    reg [0:31] conf_memory [0:41];

    initial clock = 0;
    always #10 clock = ~clock;

    initial #1000 $finish;

    FPGA fpga_inst(out, in, clock);

    initial
        begin
            in = 11'b10000000000;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b10001010010;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b10101010011;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b00110110001;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b01010011111;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b10001011101;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b11010010001;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b00101110110;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b11011111010;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);

            in = 11'b10110111011;
            #20
            $display("mux_in[0:7] : %b, control[2:0] : %b, mux_out = %b ", in[0:7], in[8:10], mux_out);
        end

    initial
        begin
            $readmemh("configure_mux.mem", conf_memory);
            fpga_inst.lt1_inst.mem = conf_memory[0];
            fpga_inst.lt2_inst.mem = conf_memory[1];
            fpga_inst.lt3_inst.mem = conf_memory[2];
            fpga_inst.lt4_inst.mem = conf_memory[3];
            fpga_inst.lt5_inst.mem = conf_memory[4];
            fpga_inst.lt6_inst.mem = conf_memory[5];
            fpga_inst.lt7_inst.mem = conf_memory[6];
            fpga_inst.lt8_inst.mem = conf_memory[7];
            fpga_inst.lt9_inst.mem = conf_memory[8];
            fpga_inst.lt10_inst.mem = conf_memory[9];
            fpga_inst.lt11_inst.mem = conf_memory[10];
            fpga_inst.lt1_inst.mem[32] = 0;
            fpga_inst.lt2_inst.mem[32] = 0;
            fpga_inst.sb1_inst.configure = conf_memory[11];
            fpga_inst.sb2_inst.configure = conf_memory[12];
            fpga_inst.sb3_inst.configure = conf_memory[13];
            fpga_inst.sb4_inst.configure = conf_memory[14];
            fpga_inst.sb5_inst.configure = conf_memory[15];
            fpga_inst.sb6_inst.configure = conf_memory[16];
            fpga_inst.sb7_inst.configure = conf_memory[17];
            fpga_inst.sb8_inst.configure = conf_memory[18];
            fpga_inst.sb9_inst.configure = conf_memory[19];
            fpga_inst.sb10_inst.configure = conf_memory[20];
            fpga_inst.sb11_inst.configure = conf_memory[21];
            fpga_inst.sb12_inst.configure = conf_memory[22];
            fpga_inst.sb13_inst.configure = conf_memory[23];
            fpga_inst.sb14_inst.configure = conf_memory[24];
            fpga_inst.sb15_inst.configure = conf_memory[25];
            fpga_inst.sb16_inst.configure = conf_memory[26];
            fpga_inst.sb17_inst.configure = conf_memory[27];
            fpga_inst.sb18_inst.configure = conf_memory[28];
            fpga_inst.sb19_inst.configure = conf_memory[29];
            fpga_inst.sb20_inst.configure = conf_memory[30];
            fpga_inst.lt1_inst.mem[32] = conf_memory[31][31];
            fpga_inst.lt2_inst.mem[32] = conf_memory[32][31];
            fpga_inst.lt3_inst.mem[32] = conf_memory[33][31]; 
            fpga_inst.lt4_inst.mem[32] = conf_memory[34][31]; 
            fpga_inst.lt5_inst.mem[32] = conf_memory[35][31];
            fpga_inst.lt6_inst.mem[32] = conf_memory[36][31];
            fpga_inst.lt7_inst.mem[32] = conf_memory[37][31];
            fpga_inst.lt8_inst.mem[32] = conf_memory[38][31];
            fpga_inst.lt9_inst.mem[32] = conf_memory[39][31];
            fpga_inst.lt10_inst.mem[32] = conf_memory[40][31];
            fpga_inst.lt11_inst.mem[32] = conf_memory[41][31];
        end

    initial
        begin
            $dumpfile("lab6_mux_dumpfile.vcd");
            $dumpvars;
        end

endmodule