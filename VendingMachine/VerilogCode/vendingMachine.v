module vendingMachine(  
    input clk, 
    input reset,
    input [1:0] money, // 01 = ?5 , 10 = ?10
    output reg out,
    output reg [1:0] change
);

    reg [1:0] ps, ns;
    parameter start = 0, rs5 = 1, rs10 = 2;

    // State update
    always @(posedge clk ) begin
        if (reset)
            ps <= start;
            
        else
            ps <= ns;
    end

    // Next state logic and outputs
    always @(*) begin
        ns = ps;
        out = 0;
        change = 0;
        case (ps)
            start: begin
                if (money == 2'b01)begin
                    ns = rs5;
                    out = 0;
                    change = 0;
                end
                else if (money == 2'b10)begin
                    ns = rs10;
                    out = 0;
                    change = 0;
                end
                else begin
                    ns = start;
                    out = 0;
                    change = 0;
                end
            end

            rs5: begin
                if (money == 2'b00) begin
                    ns = start;
                    out = 0;
                    change = 2'b01;
                end
                else if (money == 2'b01)begin
                    ns = rs10;
                    out = 0;
                    change = 0;
                end
                else begin
                    ns = start;
                    out = 1;
                    change = 0;
                end
            end

            rs10: begin
                if (money == 2'b00) begin
                    ns = start;
                    out = 0;
                    change = 2'b10;
                end
                else if (money == 2'b01) begin
                    ns = start;
                    out = 1;
                    change = 0;
                end
                else begin
                    ns = start;
                    out = 1;
                    change = 2'b01;
                end
            end
        endcase
    end
endmodule
