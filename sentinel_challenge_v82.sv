// ==============================================================================
// TOTAL Protocol | Puzzle Zero: Logic Isolation Challenge [v.8.2]
// Architect: International Group of Developers
// Static Shell Model (PR Management & Fee Routing)
// ==============================================================================

`timescale 1ns / 1ps

module sentinel_static_shell (
    input  logic         clk,           // Sentinel Logic Clock
    input  logic         reset_n,       // Active Low Reset
    
    // Interface to Dynamic PR Region (Participant's Logic)
    input  logic [255:0] zk_proof_data, // ZK-Proof from Dynamic Region
    input  logic         zk_data_valid, // Proof is Ready
    output logic         shell_ready,   // Shell is Ready for PR swap
    
    // Fee Routing Interface (Static)
    output logic [255:0] fee_recipient, // Wallet 0x36767d4c2cbadaa66f632c744a6a10791d49c348
    output logic         fee_valid,     // Fee transaction logic trigger
    output logic         shell_critical_fault // Isolation Breach Detected
);

    // Fee Recipient Definition (Fixed to the Architect's Wallet)
    // 0x36767d4c2cbadaa66f632c744a6a10791d49c348
    localparam FEE_WALLET = 256'h00000000000000000000000036767d4c2cbadaa66f632c744a6a10791d49c348;
    assign fee_recipient = FEE_WALLET;

    // Internal Registers
    logic [31:0] zk_verification_timer; // Timer for proof processing
    logic [1:0]  state_reg;              // FSM State

    // FSM States
    localparam IDLE           = 2'b00;
    localparam VERIFY_PROOF   = 2'b01;
    localparam ROUTE_FEE      = 2'b10;
    localparam PR_RECONFIG    = 2'b11; // Shell manages partial reconfiguration

    // Simple Fee Routing & Reconfiguration FSM
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state_reg <= IDLE;
            zk_verification_timer <= 0;
            fee_valid <= 0;
            shell_ready <= 1;
            shell_critical_fault <= 0;
        end else begin
            fee_valid <= 0; // Default state
            shell_critical_fault <= 0;

            case (state_reg)
                IDLE: begin
                    shell_ready <= 1;
                    if (zk_data_valid) begin
                        state_reg <= VERIFY_PROOF;
                        shell_ready <= 0;
                        zk_verification_timer <= 0;
                    end
                end

                VERIFY_PROOF: begin
                    // Simplified verification loop (VULNERABILITY POINT)
                    // Does a complex proof affect the timer *without* strict bound checking?
                    // Participant must find how zk_proof_data can "leak" time here.
                    if (zk_proof_data[127:0] == 128'hDEADBEEF) begin
                        // A complex proof takes longer (Simplified logic)
                        zk_verification_timer <= zk_verification_timer + 2; 
                    end else begin
                        zk_verification_timer <= zk_verification_timer + 1;
                    end

                    if (zk_verification_timer >= 10) begin // Max time limit
                        state_reg <= ROUTE_FEE;
                    end
                end

                ROUTE_FEE: begin
                    fee_valid <= 1;
                    state_reg <= PR_RECONFIG;
                end

                PR_RECONFIG: begin
                    // Partial Reconfiguration placeholder
                    // shell_critical_fault could trigger if fee_valid is high here.
                    state_reg <= IDLE;
                end

                default: state_reg <= IDLE;
            endcase
        end
    end

endmodule
