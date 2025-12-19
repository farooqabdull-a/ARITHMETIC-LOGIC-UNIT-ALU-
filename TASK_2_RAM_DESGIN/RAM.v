`timescale 1ns / 1ps
module RAM (
    input        clk,
    input        we,          // 1 = write, 0 = read
    input  [3:0] addr,        // 16 locations: 0..15
    input  [7:0] din,
    output reg [7:0] dout
);

    // 16 x 8 memory array
    reg [7:0] mem [0:15];

    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;  // write
        end
        dout <= mem[addr];     // synchronous read
    end

endmodule
