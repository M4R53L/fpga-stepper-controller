module pulse_generator_module (
    input wire clk,
    input wire resetb,
    output reg pulse
);

    reg [31:0] counter;
    reg [31:0] counter_limit;

    always @(posedge clk or negedge resetb) begin
        if (~resetb) begin
            counter <= 32'b0;
            pulse <= 1'b0;
        end else begin
            if (counter >= (counter_limit / 2 - 1)) begin
                counter <= 32'b0;
                pulse <= ~pulse;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
