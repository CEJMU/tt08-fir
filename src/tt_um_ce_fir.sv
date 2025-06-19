module tt_um_ce_fir (
    input logic clk,
    input logic reset,
    input logic [7:0] x, // Input Signal
    output logic [7:0] y // Output Signal
);

    // Registers:
    logic [7:0] register [2:0]; // 3 delay elements

    // Coefficients for FIR filter:
    reg [7:0] coeff [3:0];
    initial coeff[0] = 8'h01;
    initial coeff[1] = 8'h02;
    initial coeff[2] = 8'h03;
    initial coeff[3] = 8'h04;

    always_ff @( posedge clk ) begin
        if (reset) begin
            // Reset all registers to zero
            register[0] <= 8'h0000;
            register[1] <= 8'h0000;
            register[2] <= 8'h0000;
        end else begin
            register[0] <= x;           // Input to first register
            register[1] <= register[0]; // Delay by one clock cycle
            register[2] <= register[1]; // Delay by two clock cycles
        end
    end

    always_comb begin
        y = x*coeff[0] + register[0]*coeff[1] + register[1]*coeff[2] + register[2]*coeff[3]; // FIR filter output calculation
    end
endmodule