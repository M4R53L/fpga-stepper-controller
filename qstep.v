// Module for quarter step logic
module qstep (spd, start, on, rst, hs);

    input wire spd, start, rst, hs;
    output reg on;

    parameter TIME_TO_COUNT_QUARTER = 7'b0110010; // 50 in decimal
    parameter TIME_TO_COUNT_HALF = 7'b1100100;    // 100 in decimal

    reg [6:0] count; // Counter register
    reg en_count; // Enable counter register
    wire end_c_int; // Internal end count signal

	 // Assign end count based on step size
    assign end_c_int = (count == (hs ? TIME_TO_COUNT_HALF : TIME_TO_COUNT_QUARTER) - 7'b00000001);

	 // Always block for on signal logic
    always @(posedge spd or negedge rst) begin
        if (~rst) begin
            on <= 1'b0;
        end else if (on) begin
            on <= ~end_c_int;	// Turn off if end count is reached
        end else if (start) begin
            on <= 1'b1; // Start quarter step
        end
    end
	 
    // Always block for enable counter logic
	 always @(posedge spd or negedge rst) begin
        if (~rst) begin
            en_count <= 1'b0;
        end else if (start) begin
            en_count <= 1'b1;	// Enable counting
        end else if (~on) begin
            en_count <= 1'b0;	// Disable counting if not on
        end else begin
            en_count <= en_count;	// Maintain current state
        end
    end

	 // Always block for counter logic
    always @(posedge spd or negedge rst) begin
        if (~rst) begin
            count <= 7'b0;
        end else if (en_count & on) begin
            count <= count + 7'b00000001;	// Increment counter
        end else if (~on) begin
            count <= 7'b0;	// Reset counter if not on
        end else begin
            count <= 7'b0; // Default case
        end
    end

endmodule
