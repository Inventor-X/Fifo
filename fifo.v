`timescale 1ns / 1ps


module fifo(
    input [7:0] buf_in,
    input clk_w,
    input clk_r,
    input wr_en,
    input rd_en,
    input rst,
    output reg [7:0] buf_out,
    
    
    output reg empty,
    output reg full,
    output reg [6:0] counter
    
    );
    reg [6:0] wr_ptr,rd_ptr;
    reg [7:0] fifo [0:63];
    
    // checking if fifo is empty or full
    always@(counter)begin
        empty = (counter==7'd0);
        full = (counter==7'd64);
    end
    
    //updating the counter
    always@(posedge clk_w or rst)begin
        if(rst) counter<=0;
        else if(wr_en && !full) counter<=counter+7'd1;
       // else counter<= counter;
    end
    always@(posedge clk_r)begin
        if(rd_en && !empty) counter<=counter-7'd1;
        //else counter<=counter;
    end
    //writing data to fifo
    always@(posedge clk_w)begin
        if(wr_en && !full) fifo[wr_ptr]<=buf_in;
        else fifo[wr_ptr]<=fifo[wr_ptr];
        
    end
    //reading data from fifo
    always@(posedge clk_r or rst)begin
        if(rst) buf_out<=0;
        else if(rd_en && !empty) buf_out<=fifo[rd_ptr];
        else buf_out<=buf_out;
    end
    
    /// modifying write pointers;
    always@(posedge clk_w or rst)begin
        if(rst) wr_ptr<=0;
        else if(wr_en && !full) wr_ptr<=wr_ptr+7'd1;
        else wr_ptr<=wr_ptr;
        
    end
        /// modifying read  pointers;
    always@(posedge clk_r or rst)begin
        if(rst) rd_ptr<=0;
        else if(rd_en && !empty) rd_ptr<=rd_ptr+7'd1;
        else rd_ptr<=rd_ptr;
        
    end
    
endmodule
