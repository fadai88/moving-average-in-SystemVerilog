module priceThresholdDetect #
                            (parameter WINDOW = 4)
                            (input logic clk, reset,
                             input logic [9:0] price_in,
                             output logic [9:0] out);

reg [9:0] prices [WINDOW-1:0];
logic [11:0] sum;

always_comb begin
    sum = prices[0] + prices[1] + prices[2] + prices[3];
end

always_ff @(posedge clk) begin
    if (reset) begin
        out <= 0;
    end
    else begin
        prices[3:1] <= prices[2:0];
        prices[0] <= price_in;
        out <= sum / WINDOW;
    end
end        

endmodule
