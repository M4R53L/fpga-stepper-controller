// Module for speed control logic
module speed_control_module (
    input wire clk,
    input wire resetb,
    input wire speed_sel,	// Speed selection input
    output reg [31:0] counter_limit	// Counter limit output
);

	 // Parameters for different speed levels
    parameter integer TEN_SPINS = 1515151,
                      TWENTY_SPINS = 757575,
                      THIRTY_SPINS = 500000,
                      FOURTY_SPINS = 375000,
                      FIFTY_SPINS = 300000,
                      SIXTY_SPINS = 250000;

							 
    reg [31:0] speed_reg; // Register for current speed
    reg speed_sel_prev; // Previous speed selection value
    reg count_up; // Direction flag for speed adjustment

	 // Always block for speed control logic
    always @(posedge clk or negedge resetb) begin
        if (~resetb) begin
            counter_limit <= TEN_SPINS; // Reset to default speed
            speed_reg <= TEN_SPINS;	// Reset speed register
            speed_sel_prev <= 1'b0;	// Reset previous speed selection
            count_up <= 1'b0;	// Reset direction flag
        end else begin
            speed_sel_prev <= speed_sel;	// Update previous speed selection
            if (speed_sel_prev && ~speed_sel) begin 
                if (~count_up) begin
                    case (speed_reg)
                        TEN_SPINS: speed_reg <= TWENTY_SPINS;
                        TWENTY_SPINS: speed_reg <= THIRTY_SPINS;
                        THIRTY_SPINS: speed_reg <= FOURTY_SPINS;
                        FOURTY_SPINS: speed_reg <= FIFTY_SPINS;
                        FIFTY_SPINS: speed_reg <= SIXTY_SPINS;
                        SIXTY_SPINS: begin
                            speed_reg <= FIFTY_SPINS;
                            count_up <= 1'b1;	// Change direction to decrement
                        end
                        default: speed_reg <= TEN_SPINS;
                    endcase
                end else begin
                    case (speed_reg)
                        SIXTY_SPINS: speed_reg <= FIFTY_SPINS;
                        FIFTY_SPINS: speed_reg <= FOURTY_SPINS;
                        FOURTY_SPINS: speed_reg <= THIRTY_SPINS;
                        THIRTY_SPINS: speed_reg <= TWENTY_SPINS;
                        TWENTY_SPINS: speed_reg <= TEN_SPINS;
                        TEN_SPINS: begin
                            speed_reg <= TWENTY_SPINS;
                            count_up <= 1'b0;	// Change direction to increment
                        end
                        default: speed_reg <= TEN_SPINS;
                    endcase
                end
            end
            counter_limit <= speed_reg;	// Update counter limit based on speed
        end
    end

endmodule
