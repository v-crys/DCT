`timescale 1ns / 1ps


module DCT(
        input wire clk,
        input wire rst,
        
        input wire [7 : 0] in [15 : 0],
        output reg [7 : 0] out [15 : 0]
    );
    
    
    integer state_mh = 0;
    
    
    
    always @(posedge clk or negedge rst)
    begin
        if ( ~rst )
        begin
            state_mh <= 0;
            
        
        end else
        begin
            case (state_mh)
                    'd0:
                    begin
                        out[ 0 ] <= in[ 0 ] + in[15];
                        out[ 1 ] <= in[ 1 ] + in[14];
                        out[ 2 ] <= in[ 2 ] + in[13];
                        out[ 3 ] <= in[ 3 ] + in[12];
                        out[ 4 ] <= in[ 4 ] + in[11];
                        out[ 5 ] <= in[ 5 ] + in[10];
                        out[ 6 ] <= in[ 6 ] + in[9];
                        out[ 7 ] <= in[ 7 ] + in[8];
                        
                        
                        out[ 8 ] <= in[ 7 ] - in[ 8 ] ;
                        out[ 9 ] <= in[ 6 ] - in[ 9 ] ;
                        out[ 10 ] <= in[ 5 ] - in[ 10 ] ;
                        out[ 11 ] <= in[ 4 ] - in[ 11 ] ;
                        out[ 12 ] <= in[ 3 ] - in[ 12 ] ;
                        out[ 13 ] <= in[ 2 ] - in[ 13 ] ;
                        out[ 14 ] <= in[ 1 ] - in[ 14 ] ;
                        out[ 15 ] <= in[ 0 ] - in[ 15 ] ;
                        
                        state_mh <= 1;
                    end
                         
                    'd1:
                    begin
                        out[ 0 ] <= out[ 0 ] + out[ 7 ];
                        out[ 1 ] <= out[ 1 ] + out[ 6 ];
                        out[ 2 ] <= out[ 2 ] + out[ 5 ];
                        out[ 3 ] <= out[ 3 ] + out[ 4 ];
                        
                        out[ 4 ] <= out[ 3 ] - out[ 4 ];
                        out[ 5 ] <= out[ 2 ] - out[ 5 ];
                        out[ 6 ] <= out[ 1 ] - out[ 6 ];
                        out[ 7 ] <= out[ 0 ] - out[ 7 ];
                        
                        
                        out[ 8 ] <= out[ 8 ] + ((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 1) + ((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 3);
                        out[ 15 ] <= (out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) )  -  (((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 1) + ((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 3)) >> 2    +    ((((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 1) + ((out[ 15 ] - ( (out[8] >> 2) + (out[8] >> 5)*3 ) ) >> 3)) >> 5)*3 ;
                        
                        out[ 14 ] <= out[ 14 ] + (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) -  (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) >> 3;
                        out[ 9 ] <= (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) -    ( /*out 14*/(  out[ 14 ] + (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) -  (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) >> 3 /*!out 14*/ ) >> 1) +  (/*out 14*/(  out[ 14 ] + (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) -  (out[ 9 ] - (out[14] >> 1) + (3*(out[14] >> 5))) >> 3 /*!out 14*/ ) >> 5)*3;
                        
                        
                        out[ 10 ] <= /*out 10*/ (out[ 10 ] + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 2 + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 4) /*10*/;
                        out[ 13 ] <= ( out[13] - ( (out[10] >> 3) + (out[10] >> 5) ) )   -     /*out 10*/ (out[ 10 ] + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 2 + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 4) /*10*/ >> 3 + /*out 10*/ (out[ 10 ] + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 2 + (out[13] - ( (out[10] >> 3) + (out[10] >> 5) )) >> 4) /*10*/ >> 5;
                    
                    
                        out[ 12 ] <= /*out12*/ (out[ 11 ] - ( out[12] - 3*(out[12]>> 5) ) + out[ 12 ] ) /*12*/;
                        out[ 11 ] <=  (out[ 11 ] - ( out[12] - 3*(out[12]>> 5) ))  -  (/*out12*/ (out[ 11 ] - ( out[12] - 3*(out[12]>> 5) ) + out[ 12 ] ) /*12*/ - 3*(/*out12*/ (out[ 11 ] - ( out[12] - 3*(out[12]>> 5) ) + out[ 12 ] ) /*12*/ >> 5));
                        
                        state_mh <= 2;
                    end
                    
                    'd2:
                    begin
                        out[ 0 ] <= out[ 0 ] + out[ 3 ];
                        out[ 3 ] <= out[ 0 ] - out[ 3 ];
                        
                        out[ 1 ] <= out[ 1 ] + out[ 2 ];
                        out[ 2 ] <= out[ 1 ] - out[ 2 ];
                        
                        out[ 4 ] <= /*out4*/ out[ 4 ] + ( (out[ 7 ] - (out[ 4 ] >> 2) + (out[ 4 ] >> 4) ) >> 1 + (out[ 7 ] - (out[ 4 ] >> 2) + (out[ 4 ] >> 4) ) >> 4) /*4*/;
                        out[ 7 ] <=  (out[ 7 ] - (out[ 4 ] >> 2) + (out[ 4 ] >> 4) )  -  (/*out4*/ out[ 4 ] + ( (out[ 7 ] - (out[ 4 ] >> 2) + (out[ 4 ] >> 4) ) >> 1 + (out[ 7 ] - (out[ 4 ] >> 2) + (out[ 4 ] >> 4) ) >> 4) /*4*/) >> 2;
                        
                        out[ 5 ] <= /*out5*/ out[ 5 ] + 3*((out[ 6 ] - 3*(out[ 5 ] >> 5)) >> 4) /*5*/;
                        out[ 6 ] <= out[ 6 ] - 3*(out[ 5 ] >> 5) -  3*((/*out5*/ out[ 5 ] + 3*((out[ 6 ] - 3*(out[ 5 ] >> 5)) >> 4) /*5*/) >> 5);
                        
                        
                        
                        out[ 8 ] <= out[ 8 ] + out[ 11 ];
                        out[ 9 ] <= out[ 9 ] + out[ 10 ];
                        
                        out[ 10 ] <= out[ 9 ] - out[ 10 ];
                        out[ 11 ] <= out[ 8 ] - out[ 11 ];
                        
                        out[ 12 ] <= out[ 12 ] + out[ 15 ];
                        out[ 13 ] <= out[ 13 ] + out[ 14 ];
                        
                        out[ 14 ] <= out[ 13 ] - out[ 14 ];
                        out[ 15 ] <= out[ 12 ] - out[ 15 ]; 
                        
                        
                        state_mh <= 3;
                        
                    end
                    
                    'd3:
                    begin
                        out[ 0 ] <= ( out[ 0 ] + out[ 1 ] ) >> 2;
                        out[ 8 ] <= ((( ( out[ 0 ] + out[ 1 ] ) >> 2) >> 1) - out[ 1 ]) >> 1;
                        
                        out[ 12 ] <= (out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >> 2 + 3*((out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >> 5);
                        out[ 4 ] <= ( out[ 3 ] -     ((out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >> 1 - (out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >>3 ) ) >> 1 + ( out[ 3 ] -     3*((out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >> 1 - (out[ 2 ] - ( (out[ 3 ] >> 1) - (out[ 3 ] >> 4) )) >>3 ) ) >>4;
                    
                    
                        out[ 14 ] <= (((out[ 4 ] + out[ 6 ]) + out[ 5 ] + out[ 7 ]) >> 1  - (out[ 4 ] + out[ 6 ])) >> 1;
                        out[ 6 ] <= (out[ 7 ] - out[ 5 ]) >> 1 + 3*((out[ 7 ] - out[ 5 ]) >>4);
                        
                        out[ 10 ] <= (out[ 4 ] - out[ 6 ]) >> 1 + 3*( (out[ 4 ] - out[ 6 ]) >> 4 );
                        out[ 2 ] <= (out[ 7 ]+ out[ 5 ] + out[ 6 ] + out[ 4 ]) >> 2;
                        
                        
                        
                        out[ 13 ] <= (/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 4 + 3*((/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 4);
                        out[ 3 ] <=  (/*!!*/ (/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 2 + (/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 3   - (out[ 9 ] + out[ 15 ]) /*!!*/) >> 4 + 3*((/*!!*/ (/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 2 + (/*!*/( (out[ 8 ] + out[ 14 ]) + ( ( out[ 9 ] + out[ 15 ] ) >> 1 - ( out[ 9 ] + out[ 15 ] ) >> 4 ) )/*!*/) >> 3   - (out[ 9 ] + out[ 15 ]) /*!!*/) >> 5);
                        
                        out[ 9 ] <= (out[ 10 ] + out[ 11 ]) >> 4 + 3*((out[ 10 ] + out[ 11 ]) >> 5);
                        out[ 15 ] <= ((out[ 10 ] - out[ 11 ]) + ( out[ 12 ] + out[ 13 ] )) >> 2;
                        
                        out[ 1 ] <= ( (out[12] + out[ 13 ]) - (((out[ 10 ] - out[ 11 ]) + ( out[ 12 ] + out[ 13 ] )) >> 1) ) >> 1;
                        out[ 7 ] <= (out[ 12 ] - out[ 13 ]) >> 4 + 3*((out[ 12 ] - out[ 13 ]) >> 5);
                        
                        out[ 5 ] <= (/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/) >> 4 + 3*((/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/)>>5);
                        out[ 11 ] <= (/*!!*/(out[ 9 ] - out[ 15 ]) - ((/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/) >> 2 + (/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/) >> 3) /*!!*/) >> 4 + 3*((/*!!*/(out[ 9 ] - out[ 15 ]) - ((/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/) >> 2 + (/*!*/( out[ 8 ] - out[ 14 ]) + ((( out[ 9 ] - out[ 15] ) >> 1) - ( out[ 9 ] - out[ 15] ) >> 4)/*!*/) >> 3) /*!!*/) >> 5 ) ;
                        
                        state_mh <= 0;
                    end
                    
                default:
                    $stop;
                    
            endcase
        end
    end
    
    
endmodule
