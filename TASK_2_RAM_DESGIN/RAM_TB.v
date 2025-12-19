`timescale 1ns/1ps

module RAM_TB;

    reg        clk;
    reg        we;
    reg  [3:0] addr;
    reg  [7:0] din;
    wire [7:0] dout;

    integer i;

    RAM dut (
        .clk (clk),
        .we  (we),
        .addr(addr),
        .din (din),
        .dout(dout)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin

        we   = 1'b0;
        addr = 4'd0;
        din  = 8'd0;

        repeat (2) @(posedge clk);

        $display("---- RANDOM WRITE PHASE ----");
        for (i = 0; i < 8; i = i + 1) begin
            @(negedge clk);
            we   <= 1'b1;
            addr <= i[3:0];
            din  <= $random;  // random 8-bit value

            @(posedge clk);
            #1;
            $display("WRITE: time=%0t addr=%0d din=0x%0h",
                     $time, addr, din);
        end

        @(negedge clk);
        we  <= 1'b0;
        din <= 8'd0;

        @(posedge clk);

        $display("---- READ PHASE ----");
        for (i = 0; i < 8; i = i + 1) begin
            @(negedge clk);
            addr <= i[3:0];

            @(posedge clk);
            #1;
            $display("READ : time=%0t addr=%0d dout=0x%0h",
                     $time, addr, dout);
        end

        $display("---- TEST COMPLETE ----");
        repeat (2) @(posedge clk);
        $stop;
    end

endmodule
