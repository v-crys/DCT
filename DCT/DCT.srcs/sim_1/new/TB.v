`timescale 1ns / 1ps


module TB(

    );
    reg clk;
    reg res;
    reg res_dct;
    
    reg [7 : 0] in [15 : 0];
    reg [7 : 0] out [15 : 0];
    
    d_DCT d_DCT ( clk, res_dct, in, out);
    
    reg [7 : 0] test [15 : 0];
    
    integer i;
    integer k;
    
    integer state_mh;
    
    initial 
    begin
        #1;
        res = 0;
        #1;
        res = 1;
    end
        
        
        //--------------- clock control
        always 
        begin
            #10;
            clk = 'b0;
            #10;
            clk = 'b1;
        end
       
        always @( posedge clk or negedge res )
        begin
            if ( ~res )
            begin
                state_mh <= 0;           
                res_dct <= 0;
              
                i <= 0;
                k <= 0;
            end else
            begin 
                case( state_mh )
                    'd0:
                        begin
                            res_dct <= 0;
                        
                            test[ 0 ] <= 1;
                            test[ 1 ] <= 16;
                            test[ 2 ] <= 13;
                            test[ 3 ] <= 15;
                            test[ 4 ] <= 16;
                            test[ 5 ] <= 17;
                            test[ 6 ] <= 10;
                            test[ 7 ] <= 134;
                            test[ 8 ] <= 123;
                            test[ 9 ] <= 112;
                            test[ 10 ] <= 109;
                            test[ 11 ] <= 199;
                            test[ 12 ] <= 148;
                            test[ 13 ] <= 124;
                            test[ 14 ] <= 71;
                            test[ 15 ] <= 81;
                      
                               
                            state_mh <= 1;
                            k <= 0;
                            
                        end
                        
                    'd1:
                        begin
                            res_dct <= 1;
                            
                            k <= k + 1;
                            
                            if ( k == 8 )
                            begin
                                for ( i = 0; i < 16; i=i+1 )
                                begin
                                    in[ i ] <= test[ i ] * 0;
                                end
                            end else 
                            begin
                                for ( i = 0; i < 16; i=i+1 )
                                begin
                                    in[ i ] <= test[ i ] * k;
                                end
                            end
                            
                            if ( k == 16 )
                                state_mh <= 'd2;
                        end
                        
                    'd2:
                        begin
                            // wait
                            
                            
                        end
                        
                endcase
            end
        end
endmodule
