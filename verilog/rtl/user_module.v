
module user_module(
        input   wire    [26:0] io_in,
        output  wire    out
    );
    
    reg [6:0]   clock_counter_a     =   7'b0000000;
    reg [6:0]   clock_counter_b     =   7'b0000000;
    reg [6:0]   clock_counter_c     =   7'b0000000;
    reg [6:0]   clock_counter_d     =   7'b0000000;
    reg [3:0]   div_clock         =   4'b0000;

    wire [5:0]  clock_div_factor_a;
    wire [5:0]  clock_div_factor_b;
    wire [5:0]  clock_div_factor_c;
    wire [5:0]  clock_div_factor_d;
    wire [1:0]  clock_select;
    wire        clk;
    wire        clock_syn;
    
    assign  clk = io_in[0];
    assign  clock_select = io_in[2:1];
    assign  clock_syn = div_clock[clock_select];
    assign  clock_div_factor_a = io_in[8:3];
    assign  clock_div_factor_b = io_in[14:9];
    assign  clock_div_factor_c = io_in[20:15];
    assign  clock_div_factor_d = io_in[26:21];
    
    
    always @ (posedge clk) begin
        clock_counter_a <= clock_counter_a + 1;
        clock_counter_b <= clock_counter_b + 1;
        clock_counter_c <= clock_counter_c + 1;
        clock_counter_d <= clock_counter_d + 1;

        if (clock_div_factor_a < clock_counter_a) begin
            div_clock[0] <= ~div_clock[0];
            clock_counter_a <= 7'b0000000;
        end
        if (clock_div_factor_b < clock_counter_b) begin
            div_clock[1] <= ~div_clock[1];
            clock_counter_b <= 7'b0000000;
        end
        if (clock_div_factor_c < clock_counter_c) begin
            div_clock[2] <= ~div_clock[2];
            clock_counter_c <= 7'b0000000;
        end
        if (clock_div_factor_d < clock_counter_d) begin
            div_clock[3] <= ~div_clock[3];
            clock_counter_d <= 7'b0000000;
        end
    end
    
    assign out = clock_syn;
endmodule
