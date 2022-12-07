`timescale 1 ns/1 ps    

module MulMod128_on_the_fly (
    S_out,                                           
    const_in,                                                  
	B_in,                                                     
	N_in,                                                     
    rst_n,                                                 
    clk,
    Mul_sel,
    stage_counter,
    state
);

    parameter P_WIDTH     = 64 ;                                      
    parameter PD_WIDTH    = 128 ;                                     
    parameter W_WIDTH     = 32 ;  
    parameter SC_WIDTH    = 3;    
    parameter S_WIDTH   = 4 ;                                


    output reg [P_WIDTH-1:0] S_out ;                                       

    input [P_WIDTH-1:0] const_in ;                                        
    input [P_WIDTH-1:0] B_in ;                                        
    input [P_WIDTH-1:0] N_in ;                                        
    input               rst_n ;                                       
    input               clk ;    
    input               Mul_sel;
    input [SC_WIDTH-1:0] stage_counter  ;
    input [S_WIDTH-1:0] state;

    wire   [P_WIDTH-1:0] S_out_pip_in ;
    wire [P_WIDTH-1:0] B_in_tmp ;
    wire [P_WIDTH-1:0] S_out_tmp ;
    reg [3:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 4'd0;
        end else begin
            if (Mul_sel) begin
                if (cnt == 4'd15) begin
                    cnt <= 4'd0;
                end else begin
                    cnt <= cnt + 4'd1;
                end
            end
        end
    end

    assign B_in_tmp = (cnt >= 3'd4) ? S_out : B_in;

    MulMod128 m0(.S_out(S_out_pip_in),                          
                 .A_in(const_in),    //const                          
 		         .B_in(B_in_tmp),                                 
 		         .N_in(N_in),                                  
 			     .rst_n(rst_n),                                     
                 .clk(clk)                                          
                ) ;     

    on_the_fly_pip u_on_the_fly_pip0(
        //input
        .data_in(S_out_pip_in),
        .rst_n(rst_n),
        .clk(clk),
        //output
        .data_out(S_out_tmp)
    );      
    
    always @(*) begin
        if (stage_counter == 3'd2 && (state == 4'd4 || state == 4'd5 || state == 4'd6)) begin
            S_out = B_in;
        //end else if(stage_counter == 3'd3 && Mul_sel == 2'd2) begin
        //    S_out = B_in;
        end else if(state == 4'd8 || state == 4'd9 || state == 4'd10 || state == 4'd11) begin // for tmp IFFT design
            S_out = B_in;
        end else if (stage_counter == 3'd0 || stage_counter == 3'd1) begin
            if (cnt < 3'd4) begin
                S_out = B_in;
            end else begin
                S_out = S_out_tmp;
            end
        end else begin
            S_out = B_in;
        end
    end

    //assign S_out = (cnt < 3'd4) ? B_in : S_out_tmp;
endmodule