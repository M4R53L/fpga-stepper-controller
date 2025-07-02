// FSM module for controlling the step motor states
module fsm_module (
    input wire pulse,
    input wire resetb,
    input wire direction,
    input wire step_size,
    input wire on,
    input wire qstep_on, // Quarter step on input
    output reg [3:0] cs,
    output reg [3:0] ns
);

	 // State definitions
    parameter ONE = 4'b1000,
              TWO = 4'b0010,
              THREE = 4'b0100,
              FOUR = 4'b0001,
              IDLE = 4'b0000,
              HALF_ONE = 4'b1000,
              HALF_TWO = 4'b0011,
              HALF_THREE = 4'b0010,
              HALF_FOUR = 4'b0110,
              HALF_FIVE = 4'b0100,
              HALF_SIX = 4'b1100,
              HALF_SEVEN = 4'b0001,
              HALF_EIGHT = 4'b1001;

	 // Always block for updating current state
    always @(posedge pulse or negedge resetb) begin
        if (~resetb) begin
            cs <= IDLE;
        end else begin
            cs <= ns; // Update current state to next state
        end
    end

	 // Always block for determining next state based on current state and inputs
    always @(*) begin
        if (qstep_on) begin
            if (step_size) begin
                case (cs)
                    ONE: ns = direction ? TWO : FOUR;
                    TWO: ns = direction ? THREE : ONE;
                    THREE: ns = direction ? FOUR : TWO;
                    FOUR: ns = direction ? ONE : THREE;
                    IDLE: ns = ONE;
                    default: ns = IDLE;
                endcase
            end else begin
                case (cs)
                    HALF_ONE: ns = direction ? HALF_TWO : HALF_EIGHT;
                    HALF_TWO: ns = direction ? HALF_THREE : HALF_ONE;
                    HALF_THREE: ns = direction ? HALF_FOUR : HALF_TWO;
                    HALF_FOUR: ns = direction ? HALF_FIVE : HALF_THREE;
                    HALF_FIVE: ns = direction ? HALF_SIX : HALF_FOUR;
                    HALF_SIX: ns = direction ? HALF_SEVEN : HALF_FIVE;
                    HALF_SEVEN: ns = direction ? HALF_EIGHT : HALF_SIX;
                    HALF_EIGHT: ns = direction ? HALF_ONE : HALF_SEVEN;
                    IDLE: ns = HALF_ONE;
                    default: ns = IDLE;
                endcase
            end
        end else if (on) begin
            if (step_size) begin
                case (cs)
                    ONE: ns = direction ? TWO : FOUR;
                    TWO: ns = direction ? THREE : ONE;
                    THREE: ns = direction ? FOUR : TWO;
                    FOUR: ns = direction ? ONE : THREE;
                    IDLE: ns = ONE;
                    default: ns = IDLE;
                endcase
            end else begin
                case (cs)
                    HALF_ONE: ns = direction ? HALF_TWO : HALF_EIGHT;
                    HALF_TWO: ns = direction ? HALF_THREE : HALF_ONE;
                    HALF_THREE: ns = direction ? HALF_FOUR : HALF_TWO;
                    HALF_FOUR: ns = direction ? HALF_FIVE : HALF_THREE;
                    HALF_FIVE: ns = direction ? HALF_SIX : HALF_FOUR;
                    HALF_SIX: ns = direction ? HALF_SEVEN : HALF_FIVE;
                    HALF_SEVEN: ns = direction ? HALF_EIGHT : HALF_SIX;
                    HALF_EIGHT: ns = direction ? HALF_ONE : HALF_SEVEN;
                    IDLE: ns = HALF_ONE;
                    default: ns = IDLE;
                endcase
            end
        end else begin
            ns = IDLE;
        end
    end

endmodule
