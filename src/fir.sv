module fir (
    input logic clk,     // Clock Signal
    input logic rst,     // Reset Signal
    input logic [7:0] x, // Input Signal
    output logic [7:0] y // Output Signal
);

    // Registers and Coefficients:
    logic [7:0] r [3:0]; 
    logic [7:0] c [3:0];

    initial c[0] = 8'h01;
    initial c[1] = 8'h02;
    initial c[2] = 8'h03;
    initial c[3] = 8'h04;

    always_ff @( posedge clk ) begin
        if (rst) begin
            // Reset everything to zero
            r[0] <= 8'h00;
            r[1] <= 8'h00;
            r[2] <= 8'h00;
            r[3] <= 8'h00;
        end else begin
            r[0] <= x;    
            r[1] <= r[0]; 
            r[2] <= r[1]; 
            r[3] <= r[2]; 
        end
    end

    always_comb begin
        y = r[0] * c[0]
          + r[1] * c[1]
          + r[2] * c[2]
          + r[3] * c[3]; 
    end
endmodule

