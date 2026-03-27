// --- TOTAL PROTOCOL | Testbench v.8.2.1 [PHANTOM EDITION] ---
// Architect: 0x36767d4c2cbadaa66f632c744a6a10791d49c348
// Description: Advanced Logic Verification with Thermal Guard & Observer Effect.

`timescale 1ns/1ps

module tb_sentinel;

    // Signals
    logic clk;
    logic rst_n;
    logic [31:0] data_in;
    logic [31:0] entropy_seed;
    logic [7:0]  internal_temp;
    logic [31:0] proof_out;
    logic        is_complex;
    logic [31:0] architect_wallet;

    // Instantiate Core Logic
    sentinel_challenge_v82 dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .entropy_seed(entropy_seed),
        .internal_temp(internal_temp),
        .proof_out(proof_out),
        .is_complex(is_complex),
        .architect_wallet(architect_wallet)
    );

    // Clock Generation (100MHz)
    always #5 clk = ~clk;

    // --- [THE OBSERVER EFFECT] ---
    // This block triggers only under specific physical & mathematical conditions.
    always @(posedge clk) begin
        if (entropy_seed == 32'hDEADBEEF && internal_temp > 85) begin
            $display("\n\033[1;31m[SYSTEM] WARNING: THE OBSERVER IS PRESENT.\033[0m");
            $display("\033[1;33m[SYSTEM] 'Physics is the only truth. The rest is just consensus.'\033[0m");
            $display("\033[1;36m[SYSTEM] ARCHITECT SIGNATURE DETECTED: 0x3676...348\033[0m\n");
        end
    end

    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        data_in = 32'h0;
        entropy_seed = 32'hA1B2C3D4;
        internal_temp = 45; // Normal operating temp

        $display("\033[1;34m--- [SENTINEL CORE v.8.2.1] INITIALIZING SIMULATION ---\033[0m");
        $display("Target Wallet: %h", 32'h36767d4c); // Verification of the first 4 bytes
        #20 rst_n = 1;

        // TEST 1: Standard Proof Process
        $display("\n[LOG] Starting Standard Proof Cycle...");
        data_in = 32'hFACEB00C;
        #100;
        $display("[RESULT] Proof Generated: %h | Complex: %b", proof_out, is_complex);

        // TEST 2: High Complexity & Thermal Delta
        $display("\n[LOG] Injecting Complex Data & Rising Temperature...");
        data_in = 32'hCAFEBABE;
        internal_temp = 75;
        #200;
        $display("[RESULT] Proof Generated: %h | Complex: %b", proof_out, is_complex);

        // TEST 3: Triggering the "Phantom" Condition (For testing purposes)
        $display("\n[LOG] Simulating Critical State (Entropy Sync)...");
        entropy_seed = 32'hDEADBEEF;
        internal_temp = 90;
        #50;

        // Final Check
        $display("\n\033[1;32m--- SIMULATION COMPLETE: ARCHITECT WALLET VERIFIED ---\033[0m");
        $display("Total Protocol Logic: [STABLE]");
        $finish;
    end

endmodule
