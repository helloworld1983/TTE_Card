//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Wed May 29 16:01:41 2019
//Host        : LKAYA-DESKTOP running 64-bit major release  (build 9200)
//Command     : generate_target Clock_Block_wrapper.bd
//Design      : Clock_Block_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Clock_Block_wrapper
   (Crystal_Clk_in_clk_n,
    Crystal_Clk_in_clk_p,
    PLL_Clk_in,
    Sys_Clk,
    Sys_Clk_100M,
    Sys_Clk_150M,
    Sys_Clk_200M,
    Sys_Clk_Locked,
    Sys_rst);
  input [0:0]Crystal_Clk_in_clk_n;
  input [0:0]Crystal_Clk_in_clk_p;
  input PLL_Clk_in;
  output [0:0]Sys_Clk;
  output Sys_Clk_100M;
  output Sys_Clk_150M;
  output Sys_Clk_200M;
  output Sys_Clk_Locked;
  input Sys_rst;

  wire [0:0]Crystal_Clk_in_clk_n;
  wire [0:0]Crystal_Clk_in_clk_p;
  wire PLL_Clk_in;
  wire [0:0]Sys_Clk;
  wire Sys_Clk_100M;
  wire Sys_Clk_150M;
  wire Sys_Clk_200M;
  wire Sys_Clk_Locked;
  wire Sys_rst;

  Clock_Block Clock_Block_i
       (.Crystal_Clk_in_clk_n(Crystal_Clk_in_clk_n),
        .Crystal_Clk_in_clk_p(Crystal_Clk_in_clk_p),
        .PLL_Clk_in(PLL_Clk_in),
        .Sys_Clk(Sys_Clk),
        .Sys_Clk_100M(Sys_Clk_100M),
        .Sys_Clk_150M(Sys_Clk_150M),
        .Sys_Clk_200M(Sys_Clk_200M),
        .Sys_Clk_Locked(Sys_Clk_Locked),
        .Sys_rst(Sys_rst));
endmodule
