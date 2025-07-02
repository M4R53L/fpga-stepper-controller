// Module for the counter logic
module counter_module (
    input wire clk,
    input wire resetb,
    input wire [31:0] counter_limit,
    output reg [31:0] counter,
    output reg pulse
);

	 // Always block for counter and pulse logic
    always @(posedge clk or negedge resetb) begin
        if (~resetb) begin
            counter <= 32'b0;
            pulse <= 1'b0;
        end else begin
            if (counter >= (counter_limit / 2 - 1)) begin
                counter <= 32'b0;	// Reset counter when limit is reached
                pulse <= ~pulse; // Toggle pulse
            end else begin
                counter <= counter + 1; // Increment counter
            end
        end
    end

endmodule
