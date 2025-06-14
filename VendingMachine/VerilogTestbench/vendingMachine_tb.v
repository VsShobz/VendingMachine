`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 00:30:45
// Design Name: 
// Module Name: vendingMachine_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vendingMachine_tb;
    // Inputs
    reg clk, reset;
    reg [1:0] money;

    // Outputs
    wire out;
    wire [1:0] change;

    // DUT Instantiation
    vendingMachine dut(.clk(clk), .reset(reset), .money(money), .out(out), .change(change));

    // Clock generation: 10 time units period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        money = 2'b00;

        // Apply reset
        #10;         // Let clock stabilize a bit
        reset = 0;

        // Test Case: 1 -> 5 + 5 + 5
        #3 money = 2'b01;  
        #10 money = 2'b01;
        #10 money = 2'b01;        
        
        //Delay
        #10 money = 2'b00;
        
        //Test Case: 2 -> 5 + 10
        #10 money = 2'b01;
        #10 money = 2'b10;
        
        //Delay
        #10 money = 2'b00;
         
        //Test Case: 3 -> 10 + 10
        #10 money = 2'b10;
        #10 money = 2'b10;
        
        //Delay
        #10 money = 2'b00;
        
        // Test Case: 4 -> 5 + 5 + 5 + 5
        #10 money = 2'b01;  
        #10 money = 2'b01;
        #10 money = 2'b01;        
        #10 money = 2'b01;                        
        #10 money = 2'b00;
        
        // Step 3: Wait and observe
        #20;

        $finish;
    end

    always @(posedge clk) begin
        $display("Time=%0t | ps=%0d ns=%0d | money=%b | out=%b | change=%b", 
                  $time, dut.ps, dut.ns, money, out, change);
    end

endmodule

