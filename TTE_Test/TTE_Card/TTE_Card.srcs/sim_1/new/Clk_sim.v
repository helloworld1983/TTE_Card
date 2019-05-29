`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 15:35:35
// Design Name: 
// Module Name: Clk_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Clk_sim;
    reg sys_clk_p = 1;
    wire sys_clk_n;
    reg rst_n = 1;
    reg pll_clk = 1;
    wire sysclk_100;
    wire sysclk;
    wire clk_lock;

    assign sys_clk_n = ~sys_clk_p;

    initial
    begin
        #5  rst_n <= 0;
        #15 rst_n <= 1;
    end

    always
        #10  sys_clk_p <= ~sys_clk_p;

    always
        #5  pll_clk <= ~pll_clk;

    Clock_Block_wrapper cbw
    (
        .Crystal_Clk_in_clk_n   (sys_clk_n  ),
        .Crystal_Clk_in_clk_p   (sys_clk_p  ),
        .PLL_Clk_in             (pll_clk    ),
        .Sys_Clk                (sysclk     ),
        .Sys_Clk_100M           (sysclk_100 ),
        .Sys_Clk_Locked         (clk_lock   ),
        .Sys_rst                (rst_n      )
    );
endmodule
