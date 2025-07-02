// Module for quarter spin logi
module quarter_spin_module (
    input wire clk,
    input wire resetb,
    input wire quarter,	// Quarter step inout
    output reg quarter_prev,	// Previous quarter step value
    output reg quarter_spin_started, // Quarter spin started flag
    input wire qstep_on	// Quarter step on input
);

	 // Always block for quarter spin logic
    always @(posedge clk or negedge resetb) begin
        if (~resetb) begin
            quarter_prev <= 1'b1; // Reset previous value
            quarter_spin_started <= 1'b0; // Reset quarter spin flag
        end else begin
            quarter_prev <= quarter;	// Update previous value
            if (qstep_on) begin
                quarter_spin_started <= 1'b1;	// Set quarter spin flag
            end else if (quarter_prev & ~quarter) begin
                quarter_spin_started <= 1'b0;	// Reset quarter spin flag
            end
        end
    end

endmodule
