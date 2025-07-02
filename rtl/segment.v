// Module for seven segment display logic
module segment (
    input [31:0] in,	// Input value to display
    output reg [6:0] out // Output to seven segment display
);

    // Parameters for each digit
    parameter one   = 7'b1111001;
    parameter two   = 7'b0100100;
    parameter three = 7'b0110000;
    parameter four  = 7'b0011001;
    parameter five  = 7'b0010010;
    parameter six   = 7'b0000010;
	 
	 // Parameters for different speed levels
	 parameter integer TEN_SPINS = 1515151,
                      TWENTY_SPINS = 757575,
                      THIRTY_SPINS = 500000,
                      FOURTY_SPINS = 375000,
                      FIFTY_SPINS = 300000,
                      SIXTY_SPINS = 250000;
	 
	 // Always block to determine output based on input value
    always @ (in) begin
        case(in)
            TEN_SPINS: out <= one;
            TWENTY_SPINS: out <= two;
            THIRTY_SPINS: out <= three;
            FOURTY_SPINS: out <= four;
            FIFTY_SPINS: out <= five;
            SIXTY_SPINS: out <= six;
            default: out <= 7'b1111111; // Default case to handle undefined inputs
        endcase
    end

endmodule