// Module for detecting negative edge of a signal
module neg_edge_detector (
    input wire clk,
    input wire resetb,
    input wire quarter, // Quarter step input
    output wire neg_edge_quarter // Negative edge output
);

    reg quarter_prev; // Previous quarter step value

	 // Always block to update previous quarter step value
    always @(posedge clk or negedge resetb) begin
        if (~resetb) begin
            quarter_prev <= 1'b1;	// Reset previous value
        end else begin
            quarter_prev <= quarter; // Update previous value
        end
    end

	 // Assign negative edge detection
    assign neg_edge_quarter = ~quarter & ~quarter_prev;

endmodule
