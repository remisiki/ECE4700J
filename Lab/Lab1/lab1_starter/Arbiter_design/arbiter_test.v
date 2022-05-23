module testbench;

    logic clock, reset, A, B;
    logic grant_to_A, grant_to_B;

    arbiterFSM top(.clock(clock), .reset(reset), .A(A), .B(B), .grant_to_A(grant_to_A), .grant_to_B(grant_to_B));

    always begin
        #5;
        clock=~clock;
    end

    initial begin

        $monitor("Time:%4.0f clock:%b reset:%b A:%b B:%b grant_to_A:%b grant_to_B:%b", 
                 $time, clock, reset, A, B, grant_to_A, grant_to_B);

        clock = 1'b0;
        reset = 1'b1;
        A = 1'b0;
        B = 1'b0;
        //TODO: start your test here
        
        $finish;

    end

endmodule