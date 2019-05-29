//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Wed May 29 16:02:08 2019
//Host        : LKAYA-DESKTOP running 64-bit major release  (build 9200)
//Command     : generate_target Clock_Block.bd
//Design      : Clock_Block
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Clock_Block,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Clock_Block,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Clock_Block.hwdef" *) 
module Clock_Block
   (Crystal_Clk_in_clk_n,
    Crystal_Clk_in_clk_p,
    PLL_Clk_in,
    Sys_Clk,
    Sys_Clk_100M,
    Sys_Clk_150M,
    Sys_Clk_200M,
    Sys_Clk_Locked,
    Sys_rst);
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 Crystal_Clk_in CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME Crystal_Clk_in, CAN_DEBUG false, FREQ_HZ 100000000" *) input [0:0]Crystal_Clk_in_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 Crystal_Clk_in CLK_P" *) input [0:0]Crystal_Clk_in_clk_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.PLL_CLK_IN CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.PLL_CLK_IN, CLK_DOMAIN Clock_Block_clk_in1_0, FREQ_HZ 200000000, INSERT_VIP 0, PHASE 0.000" *) input PLL_Clk_in;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK, CLK_DOMAIN Clock_Block_util_ds_buf_0_0_IBUF_OUT, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) output [0:0]Sys_Clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK_100M CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK_100M, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.0" *) output Sys_Clk_100M;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK_150M CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK_150M, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 150000000, INSERT_VIP 0, PHASE 0.0" *) output Sys_Clk_150M;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLK_200M CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLK_200M, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 200000000, INSERT_VIP 0, PHASE 0.0" *) output Sys_Clk_200M;
  output Sys_Clk_Locked;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.SYS_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.SYS_RST, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input Sys_rst;

  wire [0:0]CLK_IN_D_0_1_CLK_N;
  wire [0:0]CLK_IN_D_0_1_CLK_P;
  wire clk_in1_0_1;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_clk_out2;
  wire clk_wiz_0_clk_out3;
  wire clk_wiz_0_locked;
  wire resetn_0_1;
  wire [0:0]util_ds_buf_0_IBUF_OUT;

  assign CLK_IN_D_0_1_CLK_N = Crystal_Clk_in_clk_n[0];
  assign CLK_IN_D_0_1_CLK_P = Crystal_Clk_in_clk_p[0];
  assign Sys_Clk[0] = util_ds_buf_0_IBUF_OUT;
  assign Sys_Clk_100M = clk_wiz_0_clk_out2;
  assign Sys_Clk_150M = clk_wiz_0_clk_out3;
  assign Sys_Clk_200M = clk_wiz_0_clk_out1;
  assign Sys_Clk_Locked = clk_wiz_0_locked;
  assign clk_in1_0_1 = PLL_Clk_in;
  assign resetn_0_1 = Sys_rst;
  Clock_Block_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_in1_0_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .clk_out2(clk_wiz_0_clk_out2),
        .clk_out3(clk_wiz_0_clk_out3),
        .locked(clk_wiz_0_locked),
        .resetn(resetn_0_1));
  Clock_Block_util_ds_buf_0_0 util_ds_buf_0
       (.IBUF_DS_N(CLK_IN_D_0_1_CLK_N),
        .IBUF_DS_P(CLK_IN_D_0_1_CLK_P),
        .IBUF_OUT(util_ds_buf_0_IBUF_OUT));
endmodule
