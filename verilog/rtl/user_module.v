
module user_module(
        input   wire    clk,
        input   wire    [34:0] io_in,
        output  wire    out
    );
    
    reg [8:0]   clock_counter_a     =   9'b000000000;
    reg [8:0]   clock_counter_b     =   9'b000000000;
    reg [8:0]   clock_counter_c     =   9'b000000000;
    reg [8:0]   clock_counter_d     =   9'b000000000;
    reg [3:0]   div_clock         =   4'b0000;

    wire [7:0]  clock_div_factor_a;
    wire [7:0]  clock_div_factor_b;
    wire [7:0]  clock_div_factor_c;
    wire [7:0]  clock_div_factor_d;
    wire [1:0]  clock_select;
    wire        enable;
    wire        clock_syn;
    
    assign  clock_select = io_in[1:0];
    assign  enable = io_in[34];
    assign  clock_syn = (enable)? div_clock[clock_select]:0;
    assign  clock_div_factor_a = io_in[9:2];
    assign  clock_div_factor_b = io_in[17:10];
    assign  clock_div_factor_c = io_in[25:18];
    assign  clock_div_factor_d = io_in[33:26];
    
    
    always @ (posedge clk) begin
        clock_counter_a <= clock_counter_a + 1;
        clock_counter_b <= clock_counter_b + 1;
        clock_counter_c <= clock_counter_c + 1;
        clock_counter_d <= clock_counter_d + 1;

        if (clock_div_factor_a < clock_counter_a) begin
            div_clock[0] <= ~div_clock[0];
            clock_counter_a <= 9'b000000000;
        end
        if (clock_div_factor_b < clock_counter_b) begin
            div_clock[1] <= ~div_clock[1];
            clock_counter_b <= 9'b000000000;
        end
        if (clock_div_factor_c < clock_counter_c) begin
            div_clock[2] <= ~div_clock[2];
            clock_counter_c <= 9'b000000000;
        end
        if (clock_div_factor_d < clock_counter_d) begin
            div_clock[3] <= ~div_clock[3];
            clock_counter_d <= 9'b000000000;
        end
    end
    
    assign out = clock_syn;
endmodule
