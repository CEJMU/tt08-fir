`timescale 1ns / 1ns

module testbench;
    logic clk;
    logic rst;
    logic [7:0] x; // Input Signal
    logic [7:0] y; // Output Signal

    // Instantiate the FIR filter module
    fir fir_inst (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        $dumpfile("fir_tb.vcd");
        $dumpvars(0, testbench);
        rst = 1;
        x = 16'h0000;
        #10 rst = 0; // Release reset after 10 ns

        // Apply test inputs
        x = 8'h00; #10;
        assert (y == 8'h01);
        x = 8'h01; #10;
        assert (y == 8'h01);
        x = 8'h00; #10;
        assert (y == 8'h02);
        x = 8'h00; #10;
        assert (y == 8'h03);
        x = 8'h00; #10;
        assert (y == 8'h04);
        x = 8'h00; #10;
        assert (y == 8'h00);

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t, Input: %h, Output: %h", $time, x, y);
    end
endmodule