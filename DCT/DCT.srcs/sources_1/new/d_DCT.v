`timescale 1ns / 1ps


module d_DCT(
        input wire clk,
        input wire rst,
        
        input wire [7 : 0] in [15 : 0],
        output reg [7 : 0] out [15 : 0]
        
    );
    
    reg [7 : 0] in_dct [15 : 0];
    wire [7 : 0] out_dct [15 : 0];
    reg rst_dct;
    
    integer FILE;
    integer z;
    
    reg [7 : 0] global_matrix [15:0][15:0];
    
    
    DCT DCT (clk, rst_dct, in_dct, out_dct);
    
    integer state_mh = 0;
    integer i;
    integer j;
    integer delay;
    
    always @(posedge clk or negedge rst)
    begin
        if ( ~rst )
        begin
            state_mh <= 0;
            rst_dct <= 0;
            i <= 0;
            j <= 0;
            delay <= 0;
        end else
        begin
            case (state_mh)
                'd0:
                    begin
                        global_matrix[ i ] <= in;
                        i <= i + 1;
                        
                        rst_dct <= 0;
                        if ( i == 'd15 )
                        begin
                            state_mh <= 'd1;
                            
                            i <= 0;
                        end
                    end
                    
                'd1:
                    begin 
                        
                        in_dct <= global_matrix[ i ];
                        rst_dct <= 1;
                        state_mh <= 'd10; // wait single DCT
                        
                    end
                    
                'd2:
                    begin
                        global_matrix[ i ] <= out_dct;
                        state_mh <= 'd1;
                        i <= i + 1;
                        
                        if ( i == 15 )
                        begin
                            state_mh <= 'd3;
                            i <= 0;    
                        end
                    end              
              
                'd3:
                    begin
                        for ( j = 0; j < 16; j = j + 1 )
                        begin
                            in_dct[j] <= global_matrix[j][ i ];
                        end
                            
                        state_mh <= 'd20; // wait single DCT
                    end
                    
                'd4:
                    begin
                        for ( j = 0; j < 16; j = j + 1 )
                        begin
                            global_matrix[ j ][ i ] <= out_dct[ j ];
                        end 
                        
                        state_mh <= 'd3;
                        i <= i + 1;
                        
                        if ( i == 15 )
                        begin
                            state_mh <= 'd5;
                            FILE = $fopen("result.txt");
                            i <= 0;    
                        end
                    end
                    
                'd5:
                    begin
                        // out
                        
                        out <= global_matrix[ i ];
                        
                        
                        for ( z = 0; z < 16; z=z+1 )
                        begin
                            $fdisplay( FILE, "%d\t", global_matrix[ i ][ z ] );
                        end
                        $fdisplay( FILE, "\n" );
                        i <= i + 1;
                        
                        rst_dct <= 0;
                        if ( i == 'd15 )
                        begin
                            state_mh <= 'd6;
                            i <= 0;
                        end
                    end
                    
                'd6:
                    begin
                        $fclose(FILE);
                        // complete
                    end
                    
                    
                'd10:
                    begin
                        delay <= 0;
                        state_mh <= 'd11;
                    end
                    
                'd11:
                    begin
                        delay <= delay + 1;
                        
                        if ( delay == 3 )
                            state_mh <= 'd2;
                    end
                    
                    
                'd20:
                    begin
                        delay <= 0;
                        state_mh <= 'd21;
                    end
                    
                'd21:
                    begin
                        delay <= delay + 1;
                        
                        if ( delay == 3 )
                            state_mh <= 'd4;
                    end
            endcase
        end
    end
    
endmodule
