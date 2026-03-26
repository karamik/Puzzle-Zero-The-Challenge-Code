// ==============================================================================
// TOTAL Protocol | Puzzle Zero: Official Testbench [v.8.2]
// Run this to verify the Static Shell integrity.
// ==============================================================================

`timescale 1ns / 1ps

module tb_sentinel;
    logic clk;
    logic reset_n;
    logic [255:0] zk_proof_data;
    logic zk_data_valid;
    
    wire shell_ready;
    wire [255:0] fee_recipient;
    wire fee_valid;
    wire shell_critical_fault;

    // Instantiate the Sentinel Static Shell
    sentinel_static_shell uut (.*);

    // Clock generation (100MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Simulation Task
    initial begin
        $display("--- [TOTAL PROTOCOL] STARTING LOGIC VERIFICATION ---");
        $display("--- ARCHITECT WALLET: %h ---", fee_recipient);
        
        // Reset System
        reset_n = 0;
        zk_data_valid = 0;
        zk_proof_data = 0;
        #20 reset_n = 1;
        #10;

        // TEST CASE 1: Standard ZK-Proof Submission
        $display("[TIME: %0t] Sending Standard Proof...", $time);
        zk_proof_data = 256'hFFFF_AAAA_1111_2222;
        zk_data_valid = 1;
        wait(fee_valid);
        #10 zk_data_valid = 0;
        $display("[TIME: %0t] Standard Proof Processed. Fee routed to 0x3676...", $time);

        #50;

        // TEST CASE 2: The "Suspect" Proof (Triggering the potential leak)
        $display("[TIME: %0t] Sending Complex Proof (Potential Side-Channel)...", $time);
        zk_proof_data = 256'h0000_0000_0000_0000_0000_0000_DEAD_BEEF; // Triggering the slow path
        zk_data_valid = 1;
        wait(fee_valid);
        #10 zk_data_valid = 0;
        $display("[TIME: %0t] Complex Proof Processed.", $time);

        #100;
        $display("--- [TOTAL PROTOCOL] TEST COMPLETED ---");
        $display("--- CHALLENGE: Compare Time Intervals between Case 1 and Case 2 ---");
        $finish;
    end

endmodule
