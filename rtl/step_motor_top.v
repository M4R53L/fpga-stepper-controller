// Top module for the step motor controller
module step_motor_top(
    input wire clk,		
    input wire resetb,
    input wire direction,  	// Motor direction input
    input wire speed_sel,	  	// Speed selection input
	 input wire on,        	 	// Motor on/off input
    input wire step_size,    	// Step size input (full or half)
    input wire quarter,      	// Quarter step input
    output wire [3:0] pulses_out,	// Motor pulse output
    output wire [6:0] sev_seg_o,
    output wire [6:0] sev_seg_t
);
	 // Internal wires
    wire pulse;					// To configure Clock frequency
    wire [31:0] counter_limit; // Counter to adjust the spins per minutes
    wire qstep_on;			// Quarter spin 
    wire neg_edge_quarter;	
    wire [3:0] cs;
    wire [3:0] ns;

	 // Counter module instantiation
    counter_module u_counter (
        .clk(clk),
        .resetb(resetb),
        .counter_limit(counter_limit),
        .counter(counter),
        .pulse(pulse)
    );
	
	 // Speed control module instantiation
    speed_control_module u_speed_ctrl (
        .clk(clk),
        .resetb(resetb),
        .speed_sel(speed_sel),
        .counter_limit(counter_limit)
    );

	  // Quarter spin module instantiation
    quarter_spin_module u_quarter_spin (
        .clk(clk),
        .resetb(resetb),
        .quarter(quarter),
        .quarter_prev(quarter_prev),
        .quarter_spin_started(quarter_spin_started),
        .qstep_on(qstep_on)
    );

	 // Finite State Machine (FSM) module instantiation
    fsm_module u_fsm (
        .pulse(pulse),
        .resetb(resetb),
        .direction(direction),
        .step_size(step_size),
        .on(on),
        .qstep_on(qstep_on),
        .cs(cs),
        .ns(ns)
    );

	 // Negative edge detector module instantiation
    neg_edge_detector u_neg_edge_det (
        .clk(clk),
        .resetb(resetb),
        .quarter(quarter),
        .neg_edge_quarter(neg_edge_quarter)
    );

	 // Quarter step module instantiation
    qstep my_qstep(
        .spd(pulse),
        .start(neg_edge_quarter & ~quarter_spin_started),
        .on(qstep_on),
        .rst(resetb),
        .hs(~step_size)
    );
	
	// Output assignments
    assign pulses_out = cs;
    assign sev_seg_o = 7'b1000000;	// Always display '0' on the first seven-segment display
    segment show_speed(counter_limit, sev_seg_t);	// Display speed on the second seven-segment display

endmodule
