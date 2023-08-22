`timescale 1ns / 1ps

module fifo_tb(

    );
    reg [7:0] buf_in;
    reg clk_r,clk_w,wr_en,rd_en,rst;
    wire [6:0] counter;
    wire [7:0] buf_out;
    wire empty,full;
    
    
    fifo DUT(buf_in,clk_w,clk_r,wr_en,rd_en,rst,buf_out,empty,full,counter);
    initial begin
        rst<=1;
        buf_in<=0;
        clk_w<=0;
        clk_r<=0;
        wr_en<=0;
        rd_en<=0;
    end
    always begin
        #1 clk_w<=~clk_w;
    end
    always begin
        #10 clk_r<=~clk_r;
    end
    initial begin
        #100 rst<=0;
        #20 wr_en<=1;
           buf_in<=8'd12;
        #2  buf_in<=8'd24;
        #2  buf_in<=8'd2;
        #2  buf_in<=8'd4;
        #2  buf_in<=8'd0;
        #2 wr_en<=0;
        #10 rd_en<=1;
        #200 rd_en <=0;
        
    
    
    end
endmodule
