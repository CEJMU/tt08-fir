/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_ce_fir (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 0;
  assign uio_oe  = 8'h00;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};
  logic[7:0] _foo = uio_in;

  fir fir_inst (
      .clk(clk),
      .reset(~rst_n), // Active low reset
      .x(ui_in),      // Input signal from ui_in
      .y(uo_out)      // Output signal to uo_out
  );

endmodule
